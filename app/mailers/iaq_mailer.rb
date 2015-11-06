class IaqMailer < ApplicationMailer

  def send_email(email, date = nil, type, user)
    @email = email

    if type == 0
      user = User.find_by_email 'apoioaoqueimado@yahoo.com.br'
    end

    email.email_histories.create(
        email: email,
        body: email.body,
        receipt_text: email.receipt_text,
        value: email.value,
        recipients_array: email.recipients_array,
        user: user,
        send_type: type)

    ReceiptReport.new("/tmp/recibo.pdf", email, date).save

    recipients = @email.recipients_array

    prefix = ''

    if type == 2
      prefix = I18n.t 'helpers.test_email_prefix'
    end

    attachments['recibo_.pdf'] = File.read('/tmp/recibo.pdf')
    mail(to: recipients, body: email.processed_body(date), subject: prefix + email.processed_title(date))
  end

  def send_email_daily()

    emails = Email.all#find_by_day_of_month Time.now.day

    for email in emails
        send_email email, Date.new, 0, User.first
    end
  end
end
