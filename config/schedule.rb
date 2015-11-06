# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

env :PATH, '/home/fabiow/.rbenv/plugins/ruby-build/bin:/home/fabiow/.rbenv/shims:/home/fabiow/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games'
env :GEM_PATH, ''

# Example:
#
set :output, "/home/fabiow/Development/Florianus/Florianus/log/cron.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#

#every 1.minute do
every 1.day, :at => '8:12 pm' do
  runner "EmailsController.send_email_daily"
end

# Learn more: http://github.com/javan/whenever
