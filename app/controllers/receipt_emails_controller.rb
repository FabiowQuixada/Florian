class ReceiptEmailsController < ApplicationController

  include IndexAction
  include CreationActions
  include ModificationActions
  include DestroyAction
  include StatusActions

  def index
    @list = ReceiptEmail.order('id DESC').page(params[:page])
    @recent_emails = EmailHistory.recent_emails
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
    params.require(:receipt_email).permit(:id, :body, :value, :active, :maintainer_id, :recipients_array, :active)
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
      message: genderize_tag(email, "model_phrases.past_actions.#{type}"),
      date: l(history.created_at, format: :really_short),
      maintainer: email.maintainer.name,
      value: ActionController::Base.helpers.number_to_currency(history.value),
      type: history.send_type_desc,
      user: history.user.name
    } }
  end

end
