require 'spec_helper'

# rubocop:disable all
describe 'Whenever Schedule' do
  before :all do
    load 'Rakefile' # Makes sure rake tasks are loaded so you can assert in rake jobs
  end

  let(:jobs) { Whenever::Test::Schedule.new(file: 'config/schedule.rb').jobs[:runner] }

  it { expect(jobs.count).to eq 2 }
  it { jobs.each { |job| eval job[:task] } } # Executes each job ruby code

  describe 'schedules` runtime' do
    it { expect(jobs[0][:every].to_s).to eq '[1 day, {:at=>"7:00 am"}]' }
    it { expect(jobs[1][:every].to_s).to eq '[:sunday, {:at=>"7:00 am"}]' }
  end
end
# rubocop:enable all