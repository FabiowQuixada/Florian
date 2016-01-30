class ApplicationMailer < ActionMailer::Base

    default from: "apoioaoqueimado@yahoo.com.br"

    def  send_backup_email()

        # TODO Endereço dinamico q tem no server_up.sh
        attachments['backup.tar'] = File.read(Dir['/home/fabiow/backups/db_backup/*'].sort.reverse[1] + '/db_backup.tar')

        # TODO Porque deliver now da erro aqui?
        mail(to: 'ftquixada@gmail.com',
          body: 'Banco de Producao',
          subject: I18n.t('helpers.email_tag') + ' Backup Semanal')#.deliver_now
  end

end
