require 'rails_helper'

describe ProductAndServiceDatum, type: :request do
  let(:prefix) { 'input#product_and_service_datum_product_and_service_weeks_attributes_' }

  before :each do
    login_as_admin
  end

  it 'makes sure js is working for week 0 services' do
    visit new_product_and_service_datum_path

    # Services - Week 0
    first(prefix + '0_service_data_attributes_0_psychology').set(1)
    first(prefix + '0_service_data_attributes_1_psychology').set(12)
    first(prefix + '0_service_data_attributes_0_plastic_surgery').set(3)
    first(prefix + '0_service_data_attributes_1_mesh').set(4)

    input_blur
    expect(first('input#week_1_service_psychology_total').value).to eq '13'
    expect(first('input#week_1_service_mesh_total').value).to eq '4'

    expect(first('input#total_service_checkup_week_0').value).to eq '4'
    expect(first('input#total_service_return_week_0').value).to eq '16'
    expect(first('input#total_service_week_0').value).to eq '20'
  end

  it 'makes sure js is working for week 1 services' do
    visit new_product_and_service_datum_path
    page.find('#prod_serv_data_tab_1_title').click

    # Services - Week 1
    first(prefix + '1_service_data_attributes_0_psychology').set(5)
    first(prefix + '1_service_data_attributes_1_psychology').set(6)
    first(prefix + '1_service_data_attributes_0_gynecology').set(7)
    first(prefix + '1_service_data_attributes_1_occupational_therapy').set(8)

    input_blur
    expect(first('input#week_2_service_psychology_total').value).to eq '11'
    expect(first('input#week_2_service_gynecology_total').value).to eq '7'

    expect(first('input#total_service_checkup_week_1').value).to eq '12'
    expect(first('input#total_service_return_week_1').value).to eq '14'
    expect(first('input#total_service_week_1').value).to eq '26'
  end

  it 'makes sure js is working for week 0 products' do
    visit new_product_and_service_datum_path

    # Products - Week 0
    first(prefix + '0_product_data_attributes_mask').set(10)
    first(prefix + '0_product_data_attributes_skin_expander').set(11)

    input_blur
    expect(first('input#total_product_week_0').value).to eq '21'
  end

  it 'makes sure js is working for week 1 products' do
    visit new_product_and_service_datum_path
    page.find('#prod_serv_data_tab_1_title').click

    # Products - Week 1
    first(prefix + '1_product_data_attributes_mask').set(12)
    first(prefix + '1_product_data_attributes_cervical_collar').set(13)

    input_blur
    expect(first('input#total_product_week_1').value).to eq '25'
  end
end
