# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

env :PATH, '/home/fabiow/.rbenv/plugins/ruby-build/bin:/home/fabiow/.rbenv/shims:/home/fabiow/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games'
env :GEM_PATH, ''

set :output, "/home/fabiow/Desktop/Florian/log/cron.log"

every 1.day, :at => '7:00 am' do
  runner "ReceiptEmailsController.send_email_daily", :environment => 'production'
end

every :sunday, :at => '7:00 am' do
  # TODO Application path
  command "backup perform -t db_backup --data-path " + "/home/fabiow/Desktop/Florian/" + "/backups/"
  runner "ApplicationMailer.send_backup_email.deliver_now", :environment => 'production'
end

# Learn more: http://github.com/javan/whenever
