RAILS_ENV=production bin/rake assets:precompile
cd $(dirname $0) && bundle exec whenever -s "environment=production" --update && wheneverize .
cd $(dirname $0) && rails s -e production
