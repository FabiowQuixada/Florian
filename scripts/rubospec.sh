set -e

# Formatting checkers / correctors
bundle exec rake i18n:sort
bundle exec rubocop -a

# Actual Tests
rails runner 'LocaleDuplicationChecker.run'
bundle exec rspec
./node_modules/karma/bin/karma start --single-run


# Notes
echo 'Number of rubocop disables: ' && git grep "# rubocop:disable" -- './*' ':!/doc/*' ':!/scripts/*' | wc -l
echo 'Number of TODOs: ' && git grep "TODO: " -- './*' ':!/doc/*' ':!/scripts/*' | wc -l

git gui
