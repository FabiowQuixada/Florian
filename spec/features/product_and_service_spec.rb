require 'rails_helper'

describe ProductAndServiceDatum, type: :request do
  let(:prefix) { 'input#product_and_service_datum_product_and_service_weeks_attributes_' }

  before :each do
    login_as_admin
  end

  it 'makes sure values are correctly saved and displayed' do
    visit new_product_and_service_datum_path

    # Services - Week 0
    first(prefix + '0_service_data_attributes_0_psychology').set(1)
    first(prefix + '0_service_data_attributes_1_psychology').set(12)
    first(prefix + '0_service_data_attributes_0_plastic_surgery').set(3)
    first(prefix + '0_service_data_attributes_1_mesh').set(4)
    first(prefix + '0_product_data_attributes_mask').set(10)

    click_on 'Salvar'

    visit edit_product_and_service_datum_path described_class.last

    expect(first(prefix + '0_service_data_attributes_0_psychology').value).to eq '1'
    expect(first(prefix + '0_service_data_attributes_1_psychology').value).to eq '12'
    expect(first(prefix + '0_service_data_attributes_0_plastic_surgery').value).to eq '3'
    expect(first(prefix + '0_service_data_attributes_1_mesh').value).to eq '4'
    expect(first(prefix + '0_product_data_attributes_mask').value).to eq '10'
  end
end
