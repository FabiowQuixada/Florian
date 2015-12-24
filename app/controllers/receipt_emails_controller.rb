class ReceiptEmailsController < ApplicationController

  include MainConcern
  include StatusConcern
  arguable model_class: ReceiptEmail
  load_and_authorize_resource

  def index

    @model = ReceiptEmail.new
    @list = order_emails_by_date

    @breadcrumbs = Hash[@model.model_name.human(:count => 2) => ""]

    # TODO tipo de e-mail
    @recent_emails = EmailHistory.where("created_at >= :start_date AND send_type != 2",
      {start_date: Date.new - ReceiptEmail.recent_emails_days.days})

  end

  def resend

    email = load_email

    begin

      if !email.valid?
        return render json: email.errors, status: :unprocessable_entity
      end

      IaqMailer.resend_receipt_email(email, params[:competence], current_user).deliver_now

      return render history_as_json(email, 'resent')

    rescue => exc
      exception_message = handle_exception exc, I18n.t('alert.email.error_resending')
      return render json: exception_message, status: :unprocessable_entity
    end
  end

  def send_test

    email = load_email

    begin

      if !email.valid?
        return render json: email.errors, status: :unprocessable_entity
      end

      IaqMailer.send_test_receipt_email(email, date, current_user).deliver_now

      return render history_as_json(email, 'test_sent')

    rescue Exception => exc
      exception_message = handle_exception exc, I18n.t('alert.email.error_sending_test')
      return render json: exception_message, status: :unprocessable_entity
    end
  end


  def self.send_email_daily

    emails = ReceiptEmail.where(day_of_month: Time.now.day, active: true)

    emails.each do |email|
        IaqMailer.send_automatic_receipt_email(email).deliver_now
    end
  end

  private ###########################################################################################

  def params_validation
    receipt_email_params
  end

  def receipt_email_params
    params.require(:receipt_email).permit(:id, :body, :value, :day_of_month, :active, :company_id, :recipients_array)
  end

  def order_emails_by_date

    emails = ReceiptEmail.all

    this_month_emails = Array.new
    next_month_emails = Array.new

    emails.each do |email|
      if email.current_month
        this_month_emails << email
      else
        next_month_emails << email
      end
    end

    this_month_emails.sort! { |a,b| a.day_of_month <=> b.day_of_month }
    next_month_emails.sort! { |a,b| a.day_of_month <=> b.day_of_month }

    next_month_emails = next_month_emails.sort_by do |item|
      item[:day_of_month]
    end

    this_month_emails + next_month_emails

  end

  def load_email

    # If there's anything other than the id, load it from the parameters
    # Else, load it from the database
    email = ReceiptEmail.find params[:id]

    if !params[:email_id]
      email.assign_attributes receipt_email_params
    end

    email
  end

  def history_as_json(email, type)

    history = email.email_histories.last

    return :json => {
        :message => genderize_tag(email, type),
        :date => l(history.created_at, format: :really_short),
        :company => email.company.trading_name,
        :value => ActionController::Base.helpers.number_to_currency(history.value),
        :type => history.send_type_desc,
        :user => history.user.name
      }
  end

end
