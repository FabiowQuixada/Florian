echo 'Number of rubocop disables: ' && git grep "# rubocop:disable" -- './*' ':!/doc/*' ':!/scripts/*' | wc -l
echo 'Number of TODOs: ' && git grep "TODO: " -- './*' ':!/doc/*' ':!/scripts/*' | wc -l
