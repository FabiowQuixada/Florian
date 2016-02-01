RAILS_ENV=production bin/rake assets:precompile
wheneverize .
cd $(dirname $0) && rails s -e production
