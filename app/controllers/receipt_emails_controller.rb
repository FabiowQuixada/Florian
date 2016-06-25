class ReceiptEmailsController < ApplicationController

  include MainConcern
  include StatusConcern
  arguable model_class: ReceiptEmail
  load_and_authorize_resource

  def index

    @list = order_emails_by_date

    @recent_emails = EmailHistory.where('created_at >= :start_date AND send_type != :send_type',
                                        start_date: Date.new - ReceiptEmail.recent_emails_days.days, send_type: EmailHistory.send_types[:test])

  end

  def resend

    email = load_email

    begin

      return render json: email.errors, status: :unprocessable_entity unless email.valid?

      FlorianMailer.resend_receipt_email(email, check_competence, current_user).deliver_now
      return render history_as_json(email, 'resent')

    rescue StandardError => exc
      exception_message = handle_exception exc, I18n.t('alert.email.error_resending')
      return render json: exception_message, status: :unprocessable_entity
    end
  end

  def send_test

    email = load_email

    begin

      return render json: email.errors, status: :unprocessable_entity unless email.valid?

      FlorianMailer.send_test_receipt_email(email, current_user, check_competence).deliver_now

      return render history_as_json(email, 'test_sent')

    rescue StandardError => exc
      exception_message = handle_exception exc, I18n.t('alert.email.error_sending_test')
      return render json: exception_message, status: :unprocessable_entity
    end
  end

  def self.send_email_daily

    emails = ReceiptEmail.where(day_of_month: Date.today.day, active: true)

    emails.each do |email|
      FlorianMailer.send_automatic_receipt_email(email).deliver_now
    end
  end

  private ###########################################################################################

  def receipt_email_params
    params.require(:receipt_email).permit(:id, :body, :value, :day_of_month, :active, :company_id, :recipients_array)
  end

  def order_emails_by_date

    emails = ReceiptEmail.all

    this_month_emails = []
    next_month_emails = []

    emails.each do |email|
      if email.current_month
        this_month_emails << email
      else
        next_month_emails << email
      end
    end

    this_month_emails.sort! { |a, b| a.day_of_month <=> b.day_of_month }
    next_month_emails.sort! { |a, b| a.day_of_month <=> b.day_of_month }

    next_month_emails = next_month_emails.sort_by do |item|
      item[:day_of_month]
    end

    this_month_emails + next_month_emails

  end

  def load_email

    # If there's anything other than the id, load it from the parameters
    # Else, load it from the database
    email = ReceiptEmail.find params[:id]

    email.assign_attributes receipt_email_params unless params[:email_id]

    email
  end

  def check_competence
    Date.strptime('{ 1, ' + params[:competence][0..1] + ', ' + params[:competence][3, 6] + '}', '{ %d, %m, %Y }')
  rescue
    raise FlorianException, I18n.t('alert.email.invalid_competence')
  end

  def history_as_json(email, type)

    history = email.email_histories.last

    { json: {
      message: genderize_tag(email, type),
      date: l(history.created_at, format: :really_short),
      company: email.company.name,
      value: ActionController::Base.helpers.number_to_currency(history.value),
      type: history.send_type_desc,
      user: history.user.name
    } }
  end

end
