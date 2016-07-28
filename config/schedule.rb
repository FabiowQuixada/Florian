RAILS_ROOT = File.dirname(__FILE__) + '/..'
env :GEM_PATH, ''
env :PATH, '/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games'
set :output, RAILS_ROOT + '/log/cron.log'

every 1.day, at: '7:00 am' do
  runner 'ReceiptEmailsController.send_email_daily', environment: 'production'
end

every :sunday, at: '7:00 am' do
  command 'backup perform -t db_backup --data-path ' + RAILS_ROOT + '/backups/'
  runner 'ApplicationMailer.send_backup_email.deliver_now', environment: 'production'
end
