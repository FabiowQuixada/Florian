require 'rails_helper'

describe Company, type: :model do
  it { is_expected.to define_enum_for(:entity_type) }
  it { is_expected.to define_enum_for(:category) }
  it { is_expected.to define_enum_for(:group) }
  it { is_expected.to define_enum_for(:contract) }
  it { is_expected.to define_enum_for(:payment_frequency) }


  it { is_expected.to accept_nested_attributes_for :contacts }
  it { is_expected.to accept_nested_attributes_for :donations }


  it { is_expected.to validate_presence_of(:entity_type) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:category) }
  it { is_expected.to validate_presence_of(:group) }


  # it { is_expected.to validate_uniqueness_of(:cpf) }
  # it { is_expected.to validate_uniqueness_of(:cnpj) }
  it { is_expected.to validate_uniqueness_of(:registration_name) }
  it { is_expected.to validate_uniqueness_of(:name) }


  # Relationships
  it { is_expected.to have_many :contacts }
  it { is_expected.to have_many :donations }
  it { expect(build(:company, :with_donations).valid?).to be true }
  it { expect(build(:company, :with_contacts).valid?).to be true }

  it 'does not save if it has an invalid donation' do
    company = build :company, :with_invalid_donations
    company.valid?
    expect(company.errors).not_to be_empty
  end
end
