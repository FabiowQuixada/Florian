require 'rails_helper'

describe ProductData, type: :model do
  it { is_expected.to validate_presence_of(:mesh) }
  it { is_expected.to validate_presence_of(:cream) }
  it { is_expected.to validate_presence_of(:protector) }
  it { is_expected.to validate_presence_of(:silicon) }
  it { is_expected.to validate_presence_of(:mask) }
  it { is_expected.to validate_presence_of(:foam) }
  it { is_expected.to validate_presence_of(:skin_expander) }
  it { is_expected.to validate_presence_of(:cervical_collar) }

  # Relationships
  it { is_expected.to belong_to :product_and_service_week }

  it { expect(described_class.number_of_products).to eq 8 }

  it '#qty' do
    data = build :product_data
    data.silicon = 9
    data.cream = 4
    data.skin_expander = 7

    expect(data.qty).to eq 20
  end

  it '#validate_model' do
    data = build :product_data

    expect(data.validate_model).to be true
    data.silicon = nil

    expect(data.validate_model).to be false
  end
end
