require 'rails_helper'

describe ExcelParser do
  let(:file) { Roo::Excel.new(Rails.root.join('app', 'assets', 'empresas_2016.xls')) }
  let(:row) { file.worksheets[0].rows[4] }
  let(:row_2) { file.worksheets[0].rows[29] }

  it 'loads the companies appropriately from excel file' do
    expect(described_class.parse).to be_empty
  end

  it 'parses a contact' do
    described_class.parse_contact(Company.new, 0, 0)
  end

  describe 'parses general info' do
    let(:company) { described_class.parse_general_info Company.new, row }

    it { expect(company.address).to eq 'Av. Santos Dumont, nº 3060 - Sobreloja' }
    it { expect(company.neighborhood).to eq 'Aldeota' }
    it { expect(company.cep).to eq '60150-161' }
    it { expect(company.city).to eq 'Fortaleza' }
    it { expect(company.state).to eq 'CE' }
    it { expect(company.email_address).to be_nil }
    it { expect(company.website).to be_nil }
  end

  describe 'parses basic info - PJ' do
    let(:company) { described_class.parse_basic_info Company.new, row }

    it { expect(company.company?).to be true }
    it { expect(company.name).to eq 'Casa Blanca' }
    it { expect(company.registration_name).to eq 'Casa Blanca Imóveis Ltda.' }
  end

  describe 'parses basic info - PF' do
    let(:company) { described_class.parse_basic_info Company.new, row_2 }
    it { expect(company.person?).to be true }
  end

  describe 'parses CNPJ' do
    let(:company) { described_class.parse_cpf_cnpj Company.new, row }

    it { expect(company.cnpj.numero).to eq '06.056.204/0001-20' }
  end

  describe 'parses CPF' do
    let(:company) { described_class.parse_cpf_cnpj Company.new(entity_type: 'person'), row_2 }

    it { expect(company.cpf.numero).to eq '229.915.813-87' }
  end

  it 'parses category' do
    company = described_class.parse_category Company.new, row
    expect(company.category).to eq 'medium'
  end

  it 'parses all contacts' do
    company = described_class.parse_contacts Company.new, row
    expect(company.contacts.length).to eq 3
  end

  describe 'parses a single contact' do
    let(:company) { described_class.parse_contact Company.new, 0, row }

    it { expect(company.contacts[0].name).to eq 'Sandra Brasil' }
    it { expect(company.contacts[0].position).to eq 'Dona' }
    it { expect(company.contacts[0].telephone).to eq '854006-8090' }
    it { expect(company.contacts[0].fax).to eq '854006-8097' }
    it { expect(company.contacts[0].celphone).to be_nil }
    it { expect(company.contacts[0].email_address).to eq 'sandrabrasil@me.com' }
  end

  it 'parses payment frequency' do
    company = described_class.parse_payment_frequency Company.new, row
    expect(company.payment_frequency).to eq 'monthly'
  end

  it 'parses payment period' do
    company = described_class.parse_payment_period Company.new, row
    expect(company.payment_period).to eq 0
  end

  it 'parses contract' do
    company = described_class.parse_contract Company.new, row
    expect(company.contract).to eq 'no_contract'
  end

  it 'parses first parcel' do
    company = described_class.parse_first_parcel Company.new, row
    expect(company.first_parcel).to eq Date.new(2010, 04, 15)
  end
end
