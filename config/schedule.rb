RAILS_ROOT = "#{File.expand_path(__FILE__).rpartition('Florian/')[0]}Florian".freeze
env :GEM_PATH, ''
env :PATH, "$PATH:#{RAILS_ROOT}"
set :output, "#{RAILS_ROOT}/log/cron.log"

every 1.day, at: '7:00 am' do
  runner 'ReceiptMailer.send_email_daily', environment: 'production'
end

every :sunday, at: '7:00 am' do
  command "backup perform -t db_backup -d #{RAILS_ROOT}/backups/ -l #{RAILS_ROOT}/log/"
  runner 'ApplicationMailer.send_backup_email', environment: 'production'
end

every :sunday, at: '7:00 am' do
  # TODO: Whenever - runner as a work-around
  runner ''
  command "#{RAILS_ROOT}/scripts/showcase_up.sh"
end
