require 'rails_helper'

describe ProductData, type: :model do
  # it { should validate_presence_of(:mesh) }
  # it { should validate_presence_of(:cream) }
  # it { should validate_presence_of(:protector) }
  # it { should validate_presence_of(:silicon) }
  # it { should validate_presence_of(:mask) }
  # it { should validate_presence_of(:foam) }
  # it { should validate_presence_of(:skin_expander) }
  # it { should validate_presence_of(:cervical_collar) }

  # Relationships
  it { should belong_to :product_and_service_week }
end
