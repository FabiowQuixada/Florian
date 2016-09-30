require 'rails_helper'

describe Bill, type: :model do
  it { is_expected.to validate_presence_of :competence }
  it { is_expected.to validate_presence_of :water }
  it { is_expected.to validate_presence_of :energy }
  it { is_expected.to validate_presence_of :telephone }
  it { is_expected.to validate_uniqueness_of :competence }

  it 'saves its competence as day 1 of the month' do
    bill = described_class.create!(competence: Date.new(2001, 2, 3))
    expect(bill.competence.day).to eq 1
  end

  # Methods #################################################################################

  describe '#competence_already_taken?' do
    let(:bill) { described_class.first }
    let(:new_bill) { build :bill, competence: bill.competence }
    let(:very_old_bill) { build :bill, competence: Date.new(0001, 2, 3) }

    it { expect(new_bill.send(:competence_already_taken?)).to be true }
    it { expect(very_old_bill.send(:competence_already_taken?)).to be false }
  end
end
