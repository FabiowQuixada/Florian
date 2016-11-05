require 'rails_helper'

describe ExcelParser do
  let(:file) { Roo::Excel.new(Rails.root.join('app', 'assets', 'empresas_2016.xls')) }
  let(:row) { file.worksheets[0].rows[4] }
  let(:row_2) { file.worksheets[0].rows[29] }

  it 'loads the maintainers appropriately from excel file' do
    expect(described_class.parse).to be_empty
  end

  it 'parses a contact' do
    described_class.parse_contact(Maintainer.new, 0, 0)
  end

  describe 'parses general info' do
    let(:maintainer) { described_class.parse_general_info Maintainer.new, row }

    it { expect(maintainer.address).to eq 'Av. Santos Dumont, nº 3060 - Sobreloja' }
    it { expect(maintainer.neighborhood).to eq 'Aldeota' }
    it { expect(maintainer.cep).to eq '60150-161' }
    it { expect(maintainer.city).to eq 'Fortaleza' }
    it { expect(maintainer.state).to eq 'CE' }
    it { expect(maintainer.email_address).to be_nil }
    it { expect(maintainer.website).to be_nil }
  end

  describe 'parses basic info - `company` maintainer' do
    let(:maintainer) { described_class.parse_basic_info Maintainer.new, row }

    it { expect(maintainer.company?).to be true }
    it { expect(maintainer.name).to eq 'Casa Blanca' }
    it { expect(maintainer.registration_name).to eq 'Casa Blanca Imóveis Ltda.' }
  end

  describe 'parses basic info - `person` maintainer' do
    let(:maintainer) { described_class.parse_basic_info Maintainer.new, row_2 }
    it { expect(maintainer.person?).to be true }
  end

  describe 'parses CNPJ' do
    let(:maintainer) { described_class.parse_cpf_cnpj Maintainer.new, row }

    it { expect(maintainer.cnpj.numero).to eq '06.056.204/0001-20' }
  end

  describe 'parses CPF' do
    let(:maintainer) { described_class.parse_cpf_cnpj Maintainer.new(entity_type: 'person'), row_2 }

    it { expect(maintainer.cpf.numero).to eq '229.915.813-87' }
  end

  it 'parses category' do
    maintainer = described_class.parse_category Maintainer.new, row
    expect(maintainer.category).to eq 'medium'
  end

  it 'parses all contacts' do
    maintainer = described_class.parse_contacts Maintainer.new, row
    expect(maintainer.contacts.length).to eq 3
  end

  describe 'parses a single contact' do
    let(:maintainer) { described_class.parse_contact Maintainer.new, 0, row }

    it { expect(maintainer.contacts[0].name).to eq 'Sandra Brasil' }
    it { expect(maintainer.contacts[0].position).to eq 'Dona' }
    it { expect(maintainer.contacts[0].telephone).to eq '854006-8090' }
    it { expect(maintainer.contacts[0].fax).to eq '854006-8097' }
    it { expect(maintainer.contacts[0].celphone).to be_nil }
    it { expect(maintainer.contacts[0].email_address).to eq 'sandrabrasil@me.com' }
  end

  it 'parses payment frequency' do
    maintainer = described_class.parse_payment_frequency Maintainer.new, row
    expect(maintainer.payment_frequency).to eq 'monthly'
  end

  it 'parses payment period' do
    maintainer = described_class.parse_payment_period Maintainer.new, row
    expect(maintainer.payment_period).to eq 0
  end

  it 'parses contract' do
    maintainer = described_class.parse_contract Maintainer.new, row
    expect(maintainer.contract).to eq 'no_contract'
  end

  it 'parses first parcel' do
    maintainer = described_class.parse_first_parcel Maintainer.new, row
    expect(maintainer.first_parcel).to eq Date.new(2010, 04, 15)
  end
end
