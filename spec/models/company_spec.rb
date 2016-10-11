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

  it 'does not save a `Company` without CNPJ' do
    company = build :company
    company.cnpj = nil
    company.valid?
    expect(company.errors.full_messages).to include "O campo 'CNPJ' é obrigatório;"
  end

  it 'does not save a `Person` without CPF' do
    company = build :company, :person
    company.cpf = nil
    company.valid?
    expect(company.errors.full_messages).to include "O campo 'CPF' é obrigatório;"
  end

  # Methods #################################################################################

  describe '#default_values' do
    let(:company) { build :company }

    it { expect(company.city).to eq DEFAULT_COMPANY_CITY }
    it { expect(company.state).to eq DEFAULT_COMPANY_STATE }
    it { expect(company.entity_type).to eq 'company' }
  end

  describe '#person?' do
    let(:company) { build :company, :person }
    it { expect(company.entity_type == 'person').to be true }
    it { expect(company.cpf).not_to be nil }
    it { expect(company.cnpj).to be nil }
  end

  describe '#company?' do
    let(:company) { build :company, :company }
    it { expect(company.entity_type == 'company').to be true }
    it { expect(company.cnpj).not_to be nil }
    it { expect(company.cpf).to be nil }
  end

  describe '#donation_rejectable?' do
    let(:company) { build :company }
    let(:valid_donation) { build :donation }
    let(:invalid_donation) { build :donation, :invalid }

    it { expect(company.donation_rejectable?(invalid_donation.as_json)).to be true }
    it { expect(company.donation_rejectable?(valid_donation.as_json)).to be false }
  end

  describe '#update' do
    let(:company) { described_class.first }
    let(:donation_params) { { donations_to_be_deleted: company.donations.first.id.to_s } }
    let(:contact_params) { { contacts_to_be_deleted: company.contacts.first.id.to_s } }
    let(:invalid_donation_params) { { donations_to_be_deleted: '1000' } }
    let(:invalid_contact_params) { { contacts_to_be_deleted: '1000' } }

    it 'updates the company if there was an error destroying a donation' do
      new_address = "here&there #{rand(1..1000)}"
      company.address = new_address
      company.update(donation_params)
      expect(company.address).to eq new_address
    end

    it 'updates the company if there was an error destroying a contact' do
      new_address = "here&there #{rand(1..1000)}"
      company.address = new_address
      company.update(contact_params)
      expect(company.address).to eq new_address
    end

    it 'does not update the company if there was an error destroying a donation' do
      # old_address = company.address
      company.address = "here&there #{rand(1..1000)}"
      expect { company.update(invalid_donation_params) }.to raise_error ActiveRecord::Rollback
      # expect(company.address).to eq old_address
    end

    it 'does not update the company if there was an error destroying a contact' do
      # old_address = company.address
      company.address = "here&there #{rand(1..1000)}"
      expect { company.update(invalid_contact_params) }.to raise_error ActiveRecord::Rollback
      # expect(company.address).to eq old_address
    end
  end

  describe '#unique_cnpj' do
    let(:persisted_company) { described_class.where(entity_type: 'company').first }
    let(:used_cnpj_company) { build :company, cnpj: persisted_company.cnpj }
    let(:new_cnpj_company) { build :company }

    it { expect(used_cnpj_company.valid?).to be false }
    it { expect(new_cnpj_company.valid?).to be true }
  end

  describe '#unique_cpf' do
    let(:persisted_company) { described_class.where(entity_type: 'person').first }
    let(:used_cpf_company) { build :company, :person, cpf: persisted_company.cpf }
    let(:new_cpf_company) { build :company, :person }

    it { expect(used_cpf_company.valid?).to be false }
    it { expect(new_cpf_company.valid?).to be true }
  end

  describe '#destroy_donations' do
    let(:company) { create :company, :with_donations }
    let(:params) do
      { donations_to_be_deleted: company.donations.map(&:id).to_s[1..-2] }
    end

    it 'destroy donations' do
      donation_ids = params[:donations_to_be_deleted].split(/,/)
      donation_ids.each { |id| expect(Donation.find_by_id(id)).not_to be nil }
      company.send(:destroy_donations, params)
      donation_ids.each { |id| expect(Donation.find_by_id(id)).to be nil }
    end
  end

  describe '#destroy_contacts' do
    let(:company) { create :company, :with_contacts }
    let(:params) { { contacts_to_be_deleted: company.contacts.map(&:id).to_s[1..-2] } }

    it 'destroy contacts' do
      contact_ids = params[:contacts_to_be_deleted].split(/,/)
      contact_ids.each { |id| expect(Contact.find_by_id(id)).not_to be nil }
      company.send(:destroy_contacts, params)
      contact_ids.each { |id| expect(Contact.find_by_id(id)).to be nil }
    end
  end
end
