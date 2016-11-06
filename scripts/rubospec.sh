set -e
bundle exec rubocop -a
bundle exec rake i18n:sort
bundle exec rspec
echo 'Number of rubocop disables: ' && git grep "# rubocop:disable" -- './*' ':!/doc/*' ':!/scripts/*' | wc -l
echo 'Number of TODOs: ' && git grep "TODO: " -- './*' ':!/doc/*' ':!/scripts/*' | wc -l
git gui
