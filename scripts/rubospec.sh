set -e
bundle exec rubocop -a
bundle exec rspec
echo 'Number of rubocop disables: ' && git grep "# rubocop:disable" | wc -l
echo 'Number of TODOs: ' && git grep "TODO" | wc -l
git gui
