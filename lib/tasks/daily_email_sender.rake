require 'date'


namespace :email do
  desc "TODO"
  task :daily_email_sender => :environment do
    
    IaqMailer.send_email(Email.find(3), Date.new(2001,2,3)).deliver_now
    
    puts 'aa'
    
    
    puts 'bbb'
  end
end
