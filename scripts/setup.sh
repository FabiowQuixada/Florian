sudo apt-get install libpq-dev
gem install backup
backup dependencies --install net-ssh net-scp mail
backup generate:model --trigger db_backup


cp external/isbn.rb vendor/cache/ruby/2.2.0/gems/blabla-0.0.2/lib/generators/
cp external/brdata.rb vendor/cache/ruby/2.2.0/gems/brdata-3.3.0/
cp external/db_backup.rb ~/Backup/models/