set -e

./run_formatters
./run_tests
./run_notes

git gui
