require 'rails_helper'

describe ServiceData, type: :model do
  # it { is_expected.to validate_presence_of(:psychology) }
  # it { is_expected.to validate_presence_of(:physiotherapy) }
  # it { is_expected.to validate_presence_of(:plastic_surgery) }
  # it { is_expected.to validate_presence_of(:mesh) }
  # it { is_expected.to validate_presence_of(:gynecology) }
  # it { is_expected.to validate_presence_of(:occupational_therapy) }

  # it { is_expected.to validate_inclusion_of(:service_type).in_array(ServiceData.service_types.values) }

  # Relationships
  it { is_expected.to belong_to :product_and_service_week }
end
