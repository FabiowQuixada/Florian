class ApplicationMailer < ActionMailer::Base

  default from: ENV['user_name']

  def send_backup_email

    attachments['backup.tar'] = File.read(Dir[Rails.root_to_s + '/backups/db_backup/*'].sort.reverse[1] + '/db_backup.tar')

    # TODO: Porque deliver now da erro aqui?
    mail(to: ADMIN_EMAIL,
         body: 'Banco de Producao',
         subject: I18n.t('helpers.email_tag') + ' Backup Semanal') # .deliver_now
  end

end
