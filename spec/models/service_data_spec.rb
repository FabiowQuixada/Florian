require 'rails_helper'

describe ServiceData, type: :model do
  it { is_expected.to validate_presence_of(:psychology) }
  it { is_expected.to validate_presence_of(:physiotherapy) }
  it { is_expected.to validate_presence_of(:plastic_surgery) }
  it { is_expected.to validate_presence_of(:mesh) }
  it { is_expected.to validate_presence_of(:gynecology) }
  it { is_expected.to validate_presence_of(:occupational_therapy) }

  # Relationships
  it { is_expected.to belong_to :product_and_service_week }

  it { expect(described_class.number_of_services).to eq 6 }

  # Methods #################################################################################
  it '#after_initialize' do
    serv = described_class.new
    described_class.services.each do |service|
      expect(serv.send(service.to_s)).to eq 0
    end
  end

  describe '.number_of_services' do
    it { expect(described_class.number_of_services).to eq 6 }
  end

  it '#qty' do
    data = build :service_data
    data.occupational_therapy = 9
    data.plastic_surgery = 4
    data.psychology = 7

    expect(data.qty).to eq 20
  end

  it '#validate_model' do
    data = build :service_data

    expect(data.validate_model). to be true
    data.psychology = nil

    expect(data.validate_model). to be false
  end
end
