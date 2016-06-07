require 'rails_helper'

describe Company, type: :model do
  it { should define_enum_for(:entity_type) }
  it { should define_enum_for(:category) }
  it { should define_enum_for(:group) }
  it { should define_enum_for(:contract) }
  it { should define_enum_for(:payment_frequency) }


  # it { should validate_inclusion_of(:entity_type).in_array(Company.entity_types.values) }
  # it { should validate_inclusion_of(:category).in_array(Company.categories.keys) }
  # it { should validate_inclusion_of(:group).in_array(Company.groups.keys) }
  # it { should validate_inclusion_of(:contract).in_array(Company.contracts.keys).allow_nil }
  # it { should validate_inclusion_of(:payment_frequency).in_array(Company.payment_frequencies.keys).allow_nil }


  it { should accept_nested_attributes_for :contacts }
  it { should accept_nested_attributes_for :donations }


  it { should validate_presence_of(:entity_type) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:group) }


  # it { should validate_uniqueness_of(:cpf) }
  # it { should validate_uniqueness_of(:cnpj) }
  # it { should validate_uniqueness_of(:registration_name) }
  # it { should validate_uniqueness_of(:name) }


  # Relationships
  it { should have_many :contacts }
  it { should have_many :donations }
  # it { should validate_length_of(:contacts).is_equal_to(3) }
end
