require 'rails_helper'

describe Maintainer, type: :model do
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
  it { expect(build(:maintainer, :with_donations).valid?).to be true }
  it { expect(build(:maintainer, :with_contacts).valid?).to be true }

  it 'does not save if it has an invalid donation' do
    maintainer = build :maintainer, :with_invalid_donations
    maintainer.valid?
    expect(maintainer.errors).not_to be_empty
  end

  it 'does not save a `company` maintainer without CNPJ' do
    maintainer = build :maintainer
    maintainer.cnpj = nil
    maintainer.valid?
    expect(maintainer.errors.full_messages).to include "O campo 'CNPJ' é obrigatório;"
  end

  it 'does not save a `person` maintainer without CPF' do
    maintainer = build :maintainer, :person
    maintainer.cpf = nil
    maintainer.valid?
    expect(maintainer.errors.full_messages).to include "O campo 'CPF' é obrigatório;"
  end

  # Methods #################################################################################

  describe '#default_values' do
    let(:maintainer) { build :maintainer }

    it { expect(maintainer.city).to eq DEFAULT_COMPANY_CITY }
    it { expect(maintainer.state).to eq DEFAULT_COMPANY_STATE }
    it { expect(maintainer.entity_type).to eq 'company' }
  end

  describe '#person?' do
    let(:maintainer) { build :maintainer, :person }
    it { expect(maintainer.entity_type == 'person').to be true }
    it { expect(maintainer.cpf).not_to be nil }
    it { expect(maintainer.cnpj).to be nil }
  end

  describe '#company?' do
    let(:maintainer) { build :maintainer, :company }
    it { expect(maintainer.entity_type == 'company').to be true }
    it { expect(maintainer.cnpj).not_to be nil }
    it { expect(maintainer.cpf).to be nil }
  end

  describe '#donation_rejectable?' do
    let(:maintainer) { build :maintainer }
    let(:valid_donation) { build :donation }
    let(:invalid_donation) { build :donation, :invalid }

    it { expect(maintainer.donation_rejectable?(invalid_donation.as_json)).to be true }
    it { expect(maintainer.donation_rejectable?(valid_donation.as_json)).to be false }
  end

  describe '#contact_rejectable?' do
    let(:maintainer) { build :maintainer }
    let(:valid_contact) { build :contact }
    let(:invalid_contact) { build :contact, :no_data }

    it { expect(maintainer.contact_rejectable?(invalid_contact.as_json)).to be true }
    it { expect(maintainer.contact_rejectable?(valid_contact.as_json)).to be false }
  end

  describe '#update' do
    let(:maintainer) { described_class.first }
    let(:donation_params) { { donations_to_be_deleted: maintainer.donations.first.id.to_s } }
    let(:contact_params) { { contacts_to_be_deleted: maintainer.contacts.first.id.to_s } }
    let(:invalid_donation_params) { { donations_to_be_deleted: '1000' } }
    let(:invalid_contact_params) { { contacts_to_be_deleted: '1000' } }

    it 'updates the maintainer if there was no error destroying a donation' do
      new_address = "here&there #{rand(1..1000)}"
      maintainer.address = new_address
      maintainer.update(donation_params)
      expect(maintainer.address).to eq new_address
    end

    it 'updates the maintainer if there was no error destroying a contact' do
      new_address = "here&there #{rand(1..1000)}"
      maintainer.address = new_address
      maintainer.update(contact_params)
      expect(maintainer.address).to eq new_address
    end

    it 'does not update the maintainer if there was an error destroying a donation' do
      old_address = maintainer.address
      maintainer.address = "here&there #{rand(1..1000)}"
      expect { maintainer.update(invalid_donation_params) }.to raise_error ActiveRecord::Rollback
      expect(described_class.first.address).to eq old_address
    end

    it 'does not update the maintainer if there was an error destroying a contact' do
      old_address = maintainer.address
      maintainer.address = "here&there #{rand(1..1000)}"
      expect { maintainer.update(invalid_contact_params) }.to raise_error ActiveRecord::Rollback
      expect(described_class.first.address).to eq old_address
    end
  end

  describe '#unique_cnpj' do
    let(:persisted_maintainer) { described_class.where(entity_type: 'company').first }
    let(:used_cnpj_maintainer) { build :maintainer, cnpj: persisted_maintainer.cnpj }
    let(:new_cnpj_maintainer) { build :maintainer }

    it { expect(used_cnpj_maintainer.valid?).to be false }
    it { expect(new_cnpj_maintainer.valid?).to be true }
  end

  describe '#unique_cpf' do
    let(:persisted_maintainer) { described_class.where(entity_type: 'person').first }
    let(:used_cpf_maintainer) { build :maintainer, :person, cpf: persisted_maintainer.cpf }
    let(:new_cpf_maintainer) { build :maintainer, :person }

    it { expect(used_cpf_maintainer.valid?).to be false }
    it { expect(new_cpf_maintainer.valid?).to be true }
  end

  describe '#destroy_donations' do
    let(:maintainer) { create :maintainer, :with_donations }
    let(:params) do
      { donations_to_be_deleted: maintainer.donations.map(&:id).to_s[1..-2] }
    end

    it 'destroy donations' do
      donation_ids = params[:donations_to_be_deleted].split(/,/)
      donation_ids.each { |id| expect(Donation.find_by_id(id)).not_to be nil }
      maintainer.send(:destroy_donations, params)
      donation_ids.each { |id| expect(Donation.find_by_id(id)).to be nil }
    end
  end

  describe '#destroy_contacts' do
    let(:maintainer) { create :maintainer, :with_contacts }
    let(:params) { { contacts_to_be_deleted: maintainer.contacts.map(&:id).to_s[1..-2] } }

    it 'destroy contacts' do
      contact_ids = params[:contacts_to_be_deleted].split(/,/)
      contact_ids.each { |id| expect(Contact.find_by_id(id)).not_to be nil }
      maintainer.send(:destroy_contacts, params)
      contact_ids.each { |id| expect(Contact.find_by_id(id)).to be nil }
    end
  end
end
