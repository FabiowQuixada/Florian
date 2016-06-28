require 'rails_helper'

describe ServiceData, type: :model do
  # it { should validate_presence_of(:psychology) }
  # it { should validate_presence_of(:physiotherapy) }
  # it { should validate_presence_of(:plastic_surgery) }
  # it { should validate_presence_of(:mesh) }
  # it { should validate_presence_of(:gynecology) }
  # it { should validate_presence_of(:occupational_therapy) }

  # it { should validate_inclusion_of(:service_type).in_array(ServiceData.service_types.values) }

  # Relationships
  it { should belong_to :product_and_service_week }
end
