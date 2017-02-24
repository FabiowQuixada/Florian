bundle exec rake i18n:sort
bundle exec rake i18n:js:export
bundle exec rubocop -a
rails runner 'LocaleDuplicationChecker.run'