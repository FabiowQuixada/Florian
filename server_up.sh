RAILS_ENV=production bin/rake assets:precompile
cd $(dirname $0) && bundle exec whenever -s "environment=production" --update && wheneverize .
cd $(dirname $0) && rails s -b ec2-52-67-11-119.sa-east-1.compute.amazonaws.com -p 80 -e production
