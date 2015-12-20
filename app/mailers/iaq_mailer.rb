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

  def send_prod_and_serv_email(email, user)
      recipients = 'ftquixada@gmail.com'#email.recipients_array

      ProductAndServiceReport.new("/tmp/prod_serv.pdf", email, Date.today).save
      attachments['relatorio_de_produtos_e_servicos.pdf'] = File.read('/tmp/prod_serv.pdf')

      mail(to: recipients,
        bcc: user.bcc,
        body: email.processed_body(Date.today) + " \n \n-- \n" + user.signature,
        subject: email.processed_title(Date.today))
  end

  def send_prod_and_serv_test_email(email, user)

      ProductAndServiceReport.new("/tmp/prod_serv.pdf", email, Date.today).save
      attachments['relatorio_de_produtos_e_servicos.pdf'] = File.read('/tmp/prod_serv.pdf')

      send_test_email(email, email.competence, user)
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

    def send_test_email(email, date, user)
      mail(to: user.email,
        body: email.processed_body(date) + " \n \n-- \n" + user.signature,
        subject: I18n.t('helpers.test_email_prefix') + email.processed_title(date))
    end
end
