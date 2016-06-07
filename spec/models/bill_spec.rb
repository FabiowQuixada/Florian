require 'rails_helper'

describe Bill, type: :model do
  it 'saves its competence as day 1 of the month' do
    bill = described_class.create!(competence: Date.new(2001, 2, 3))
    expect(bill.competence.day).to eq 1
  end

  it { should validate_presence_of :competence }
  it { should validate_presence_of :water }
  it { should validate_presence_of :energy }
  it { should validate_presence_of :telephone }

  it { should validate_uniqueness_of :competence }
end
