require 'rails_helper'

describe ProductAndServiceDatum, type: :model do
  it { should define_enum_for(:status) }
  # it { should validate_inclusion_of(:status), in: ProductAndServiceDatum.statuses.keys }

  it { should accept_nested_attributes_for :product_and_service_weeks }

  it { should validate_presence_of(:competence) }
  it { should validate_presence_of(:status) }

  it { should validate_uniqueness_of(:competence) }

  # Relationships
  it { should have_many :product_and_service_weeks }
  # it { should validate_length_of(:product_and_service_weeks).is_equal_to(7) }
end
