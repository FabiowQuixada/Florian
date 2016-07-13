require 'rails_helper'

# rubocop:disable all
describe 'Commands' do
  it 'searches for byebug occurrences' do
    filename = 'byebug'
    command = `git grep byebug ./app > tmp/#{filename}.txt && wc -l tmp/#{filename}.txt`
    expect(command).to be_empty
  end

  it 'searches for <<<<<< occurrences' do
    filename = 'conflict_start'
    command = `git grep "<<<<<<" ./app > tmp/#{filename}.txt && wc -l tmp/#{filename}.txt`
    expect(command).to be_empty
  end

  it 'searches for >>>>>> occurrences' do
    filename = 'conflict_end'
    command = `git grep ">>>>>" ./app > tmp/#{filename}.txt && wc -l tmp/#{filename}.txt`
    expect(command).to be_empty
  end
end
# rubocop:enable all