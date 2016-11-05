require 'rails_helper'

describe Donation, type: :model do
  it { expect(build(:donation, value: 0.00).send(:no_value?)).to be true }
  it { is_expected.to validate_presence_of(:donation_date) }

  # Relationships
  it { is_expected.to belong_to :maintainer }

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

  # Methods #################################################################################

  describe '#validate_model' do
    it { expect((build :donation, :invalid).send(:validate_model)).to eq [I18n.t('errors.donation.value_or_remark')] }
  end

  describe '#no_value?' do
    it { expect((build :donation, value: nil).send(:no_value?)).to be true }
    it { expect((build :donation, value: 0).send(:no_value?)).to be true }
    it { expect((build :donation, value: 1.14).send(:no_value?)).to be false }
  end

  describe '#no_remark?' do
    it { expect((build :donation, remark: nil).send(:no_remark?)).to be true }
    it { expect((build :donation, remark: '').send(:no_remark?)).to be true }
    it { expect((build :donation, remark: 'remark').send(:no_remark?)).to be false }
  end
end
