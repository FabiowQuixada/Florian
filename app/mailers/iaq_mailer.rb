class IaqMailer < ApplicationMailer

  def send_test_receipt_email(email, date = nil, user)
    send_email(email, date, user, EmailHistory.send_types[:test], I18n.t('helpers.test_email_prefix'), user.email)

  end

  def resend_receipt_email(email, date, user)
    send_email(email, date, user, EmailHistory.send_types[:resend])
  end

  def send_automatic_receipt_email(email)
    send_email email, date, User.find_by_email('apoioaoqueimado@yahoo.com.br')
  end


  # def send_receipt_email_daily()

  #   # TODO active
  #   emails = ReceiptEmail.find_by_day_of_month Time.now.day

  #   for email in emails
  #       send_email email, Date.new, 0, User.first
  #   end
  # end

  private

    def send_email(email, date, user, type, prefix = '', recipients = nil)

      if recipients.nil?
        recipients = email.recipients_array
      end

      email.email_histories.create(
          receipt_email: email,
          body: email.body,
          value: email.value,
          recipients_array: email.recipients_array,
          user: user,
          send_type: type)

      ReceiptReport.new("/tmp/recibo.pdf", email, date).save
      attachments['recibo_de_doacao.pdf'] = File.read('/tmp/recibo.pdf')

      mail(to: recipients,
        bcc: user.bcc,
        body: email.processed_body(date) + " \n \n-- \n" + user.signature,
        subject: prefix + email.processed_title(date))
    end
end
