# User Acceptance Test
bundle exec rake db:migrate RAILS_ENV=uat
rails s Puma -b ec2-52-67-11-119.sa-east-1.compute.amazonaws.com -p 5000 -e uat &
