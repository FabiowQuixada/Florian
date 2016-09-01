# Showcase
kill -9 $(lsof -ti tcp:4000)
bundle exec rake db:drop db:create db:migrate db:seed RAILS_ENV=showcase
rails s Puma -b ec2-52-67-11-119.sa-east-1.compute.amazonaws.com -p 4000 -e showcase &
