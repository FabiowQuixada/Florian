bundle exec rake i18n:sort
bundle exec rake i18n:js:export
bundle exec rubocop -a
bundle exec rake build_client_data:all
./node_modules/.bin/eslint app/frontend/ spec/javascripts/ --fix
rails runner 'LocaleDuplicationChecker.run'
