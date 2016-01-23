class IaqMailer < ApplicationMailer

  def send_test_receipt_email(email, date = nil, user)
    send_email(email, date, user, EmailHistory.send_types[:test], I18n.t('helpers.test_email_prefix'), user.email)
  end

  def resend_receipt_email(email, date, user)
    send_email(email, date, user, EmailHistory.send_types[:resend])
  end

  def send_automatic_receipt_email(email)
    send_email email, Date.today, User.find_by_email('ftquixada@gmail.com'), EmailHistory.send_types[:auto]
  end

  def send_prod_and_serv_email(email, user)

      ProductAndServiceReport.new("/tmp/prod_serv.pdf", email).save
      attachments['relatorio_de_produtos_e_servicos.pdf'] = File.read('/tmp/prod_serv.pdf')

      mail(to: user.system_setting.pse_recipients_array,
        body: email.processed_body(user),
        subject: email.processed_title(user))
  end

  def send_prod_and_serv_test_email(email, user)

      ProductAndServiceReport.new("/tmp/prod_serv.pdf", email).save
      attachments['relatorio_de_produtos_e_servicos.pdf'] = File.read('/tmp/prod_serv.pdf')

      send_test_email(email, email.competence, user)
  end

  private

    def send_email(email, date, user, type, prefix = '', recipients = nil)

      if recipients.nil?
        recipients = email.recipients_array
      end

      ReceiptReport.new("/tmp/recibo.pdf", email, date).save
      attachments['recibo_de_doacao.pdf'] = File.read('/tmp/recibo.pdf')

      mail(to: recipients,
        body: email.processed_body(user, date),
        subject: prefix + email.processed_title(user, date))

      email.email_histories.create(
          receipt_email: email,
          body: email.body,
          value: email.value,
          recipients_array: email.recipients_array,
          user: user,
          send_type: type)
    end

    def send_test_email(email, date, user)
      mail(to: user.email,
        body: email.processed_body(user, date),
        subject: I18n.t('helpers.test_email_prefix') + email.processed_title(user, date))
    end

end
