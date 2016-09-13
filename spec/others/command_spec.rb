require 'rails_helper'

describe 'Commands' do
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

  it 'makes sures there is not any rubocop warning' do
    expect(`bundle exec rubocop; echo $?`).to include 'no offenses detected'
  end
end
