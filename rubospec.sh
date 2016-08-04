set -e
bundle exec rubocop -a
bundle exec rspec
git gui
