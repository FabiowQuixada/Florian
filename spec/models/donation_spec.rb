require 'rails_helper'

describe Donation, type: :model do
  it 'does not save if there is no value and no remark' do
    model = build(:donation, value: nil, remark: nil)
    model.valid?
    expect(model.errors).not_to be_empty
  end

  it 'saves if there is a remark' do
    model = build(:donation, value: nil, remark: 'remark')
    model.valid?
    expect(model.errors).to be_empty
  end

  it 'does not save if there is a empty remark' do
    model = build(:donation, value: nil, remark: '')
    model.valid?
    expect(model.errors).not_to be_empty
  end

  it 'saves if there is a value' do
    model = build(:donation, value: 4.00, remark: nil)
    model.valid?
    expect(model.errors).to be_empty
  end

  it 'does not save if there is a 0.00 value' do
    model = build(:donation, value: 0.00, remark: nil)
    model.valid?
    expect(model.errors).not_to be_empty
  end

  it { expect(build(:donation, value: 0.00).send(:no_value?)).to be true }

  it { is_expected.to belong_to :company }

  it { is_expected.to validate_presence_of(:donation_date) }
  it { is_expected.to validate_presence_of(:company) }

  # Relationships
  it { is_expected.to belong_to :company }
end
