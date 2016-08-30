RAILS_ROOT = File.dirname(__FILE__) + '/..'
env :GEM_PATH, ''
env :PATH, '/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games'
set :output, RAILS_ROOT + '/log/cron.log'

every 1.day, at: '7:00 am' do
  runner 'ReceiptMailer.send_email_daily', environment: 'production'
end

every :sunday, at: '7:00 am' do
  command "backup perform -t db_backup -d #{RAILS_ROOT}/backups/ -l #{RAILS_ROOT}/log/"
  runner 'ApplicationMailer.send_backup_email.deliver_now', environment: 'production'
end
