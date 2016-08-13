
# Showcase
bundle exec rake db:migrate RAILS_ENV=showcase
rails s Puma -b ec2-52-67-11-119.sa-east-1.compute.amazonaws.com -p 4000 -e showcase &


# User Acceptance Test
bundle exec rake db:migrate RAILS_ENV=uat
rails s Puma -b ec2-52-67-11-119.sa-east-1.compute.amazonaws.com -p 5000 -e uat &


# Production
RAILS_ENV=production bin/rake assets:precompile
bundle exec rake db:migrate RAILS_ENV=production
cd $(dirname $0) && bundle exec whenever -s "environment=production" --update && wheneverize .
cd $(dirname $0) && rails s Puma -b ec2-52-67-11-119.sa-east-1.compute.amazonaws.com -e production &
