require 'rails_helper'

describe Donation, type: :model do
  it 'does not save if there is no value and no observation' do
    before_count = described_class.count
    described_class.create(donation_date: Date.new(2001, 2, 3))
    expect(described_class.count).to eq(before_count)
  end

  it { should validate_presence_of(:donation_date) }
  it { should validate_presence_of(:company) }

  # Relationships
  it { should belong_to :company }
end
