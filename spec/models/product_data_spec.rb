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
end
