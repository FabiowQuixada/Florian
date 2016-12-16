bundle exec rake i18n:sort
bundle exec rubocop -a
rails runner 'LocaleDuplicationChecker.run'