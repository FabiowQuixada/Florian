class ReceiptEmailsController < ApplicationController

  include IndexAction
  include CreationActions
  include ModificationActions
  include DestroyAction
  include StatusActions

  def index
    @list = order_emails_by_date

    @recent_emails = EmailHistory.where('created_at >= :start_date AND send_type != :send_type',
                                        start_date: Date.new - ReceiptEmail.recent_emails_days.days,
                                        send_type: EmailHistory.send_types[:test])
  end

  def resend
    email = load_email
    return render json: email.errors, status: :unprocessable_entity unless email.valid?

    ReceiptMailer.resend_receipt_email(email, convert_competence, current_user).deliver_now
    return render history_as_json(email, 'resent')

  rescue StandardError => exc
    exception_message = handle_exception exc, I18n.t('alert.email.error_resending')
    return render json: exception_message, status: :internal_server_error
  end

  def send_test
    email = load_email
    return render json: email.errors, status: :unprocessable_entity unless email.valid?

    ReceiptMailer.send_test_receipt_email(email, current_user, convert_competence).deliver_now
    return render history_as_json(email, 'test_sent')

  rescue StandardError => exc
    exception_message = handle_exception exc, I18n.t('alert.email.error_sending_test')
    return render json: exception_message, status: :internal_server_error
  end

  private ###########################################################################################

  def receipt_email_params
    params.require(:receipt_email).permit(:id, :body, :value, :day_of_month, :active, :company_id, :recipients_array)
  end

  def order_emails_by_date
    this_month_emails, next_month_emails = receipts_by_month
    receipts_by_day this_month_emails, next_month_emails
  end

  def receipts_by_month
    this_month_emails = []
    next_month_emails = []

    ReceiptEmail.all.each do |email|
      if email.current_month?
        this_month_emails << email
      else
        next_month_emails << email
      end
    end

    [this_month_emails, next_month_emails]
  end

  def receipts_by_day(this_month_emails, next_month_emails)
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

  def convert_competence
    FlorianDateHelper.competence_to_date params[:competence]
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
