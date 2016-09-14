class ApplicationMailer < ActionMailer::Base

  default from: ENV['user_name']

  def send_backup_email
    attachments['backup.tar'] = File.read(Dir["#{Rails.root}/backups/db_backup/*"].sort.reverse[1] + '/db_backup.tar')

    # TODO: Porque deliver now da erro aqui?
    mail(to: ADMIN_EMAIL,
         subject: I18n.t('helpers.email_tag') + I18n.t('helpers.email.production_db_backup.subject'),
         body: I18n.t('helpers.email.production_db_backup.body')
    ) # .deliver_now
  end

  def file_name
    '/tmp/report.pdf'
  end

end
