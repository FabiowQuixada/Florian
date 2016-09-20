class ReceiptMailer < ApplicationMailer

  def send_email_daily

    emails = ReceiptEmail.where(day_of_month: Date.today.day, active: true)

    emails.each do |email|
      send_automatic_receipt_email(email).deliver_now
    end
  end

  def send_test_receipt_email(email, user, date = nil)
    send_email(email, date, user, EmailHistory.send_types[:test], user.email)
  end

  def resend_receipt_email(email, date, user)
    send_email(email, date, user, EmailHistory.send_types[:resend])
  end

  def send_automatic_receipt_email(email)
    send_email email, Date.today, User.find_by_email(SYSTEM_EMAIL), EmailHistory.send_types[:auto]
  end

  private

  def send_email(email, date, user, type, recipients = nil)

    recipients = email.recipients_array if recipients.nil?

    attach_receipt email, date

    prefix = ''
    prefix = I18n.t('helpers.test_email_prefix') if type == EmailHistory.send_types[:test]

    mail(to: recipients,
         body: email.processed_body(user, date),
         subject: prefix + email.processed_title(user, date))

    save_to_history email, type, user

  end

  def send_test_email(email, date, user)
    mail(to: user.email,
         body: email.processed_body(user, date),
         subject: I18n.t('helpers.test_email_prefix') + email.processed_title(user, date))
  end

  def attach_receipt(email, date)
    ReceiptReport.new(file_name, email, date).save
    attachments[attachment_name(date)] = File.read(file_name)
    File.delete(file_name)
  end

  def attachment_name(date)
    "recibo_de_doacao_#{l(date, format: '%B').downcase}_#{date.year}.pdf"
  end

  def save_to_history(email, type, user)
    email.email_histories.create(
      receipt_email: email,
      body: email.body,
      value: email.value,
      recipients_array: email.recipients_array,
      user: user,
      send_type: type
    )
  end

end
