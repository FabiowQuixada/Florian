RAILS_ENV=production bin/rake assets:precompile
wheneverize .
rails s -e production

