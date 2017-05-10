require 'rails_helper'

describe ProductAndServiceDatum, js: true, type: :request do
  describe 'filters' do
    let(:start) { '02/2016' }
    let(:final) { '06/2016' }

    before :each do
      login_as_admin
      visit product_and_service_data_path
      click_on I18n.t 'helpers.filters'
    end

    describe 'by date' do
      before :each do
        fill_in 'aux_competence_gteq', with: start
        fill_in 'aux_competence_lteq', with: final
        click_on I18n.t 'helpers.action.apply'
      end

      it { expect(page).not_to have_content I18n.t('errors.messages.invalid_period_i') }
      it { expect_dates_to_be_in_interval }
      it { expect_info_msg_to_include 'found' }
    end

    it 'displays message if the period is invalid' do
      fill_in 'aux_competence_gteq', with: final
      fill_in 'aux_competence_lteq', with: start
      click_on I18n.t 'helpers.action.apply'

      expect(page).to have_content I18n.t('errors.messages.invalid_period_i')
    end
  end

  describe 'form' do
    before :each do
      login_as_admin
      visit new_product_and_service_datum_path
    end

    context 'is persisted' do
      before :each do
        fill_fields
        click_on_save_btn
        visit edit_product_and_service_datum_path described_class.last
      end

      it { expect(find('#w0_service_psychology_c0').value).to eq '1' }
      it { expect(find('#w0_service_psychology_c1').value).to eq '12' }
      it { expect(find('#w0_service_plastic_surgery_c0').value).to eq '3' }
      it { expect(find('#w0_service_mesh_c1').value).to eq '4' }
      it { expect(find('#w0_product_mask').value).to eq '10' }
    end

    it 'makes sure js is working for week 0 services' do
      fill_week_0_services
      check_week_0_totals_column
      check_week_0_footer_row
    end

    it 'makes sure js is working for week 1 services' do
      go_to_week_1_tab
      fill_week_1_services
      check_week_1_totals_column
      check_week_1_footer_row
    end

    it 'makes sure js is working for week 0 products' do
      fill_week_0_products
      check_week_0_products_total
    end

    it 'makes sure js is working for week 1 products' do
      go_to_week_1_tab
      fill_week_1_products
      check_week_1_products_total
    end
  end

  # Helper methods ################################################################################

  def fill_week_0_services
    find('#w0_service_psychology_c0').set(1)
    find('#w0_service_psychology_c1').set(12)
    find('#w0_service_plastic_surgery_c0').set(3)
    find('#w0_service_mesh_c1').set(4)
  end

  def fill_week_0_products
    find('#w0_product_mask').set(10)
    find('#w0_product_skin_expander').set(11)
  end

  def check_week_0_totals_column
    input_blur
    expect(find('#w0_service_psychology_total').value).to eq '13'
    expect(find('#w0_service_mesh_total').value).to eq '4'
  end

  def check_week_0_footer_row
    input_blur
    expect(find('#w0_service_checkup_total').value).to eq '4'
    expect(find('#w0_service_return_total').value).to eq '16'
    expect(find('#w0_service_absolute_total').value).to eq '20'
  end

  def check_week_0_products_total
    input_blur
    expect(find('#w0_product_total').value).to eq '21'
  end

  def fill_week_1_services
    find('#w1_service_psychology_c0').set(5)
    find('#w1_service_psychology_c1').set(6)
    find('#w1_service_gynecology_c0').set(7)
    find('#w1_service_occupational_therapy_c1').set(8)
  end

  def fill_week_1_products
    find('#w1_product_mask').set(12)
    find('#w1_product_cervical_collar').set(13)
  end

  def check_week_1_totals_column
    input_blur
    expect(find('#w1_service_psychology_total').value).to eq '11'
    expect(find('#w1_service_gynecology_total').value).to eq '7'
  end

  def check_week_1_footer_row
    input_blur
    expect(find('#w1_service_checkup_total').value).to eq '12'
    expect(find('#w1_service_return_total').value).to eq '14'
    expect(find('#w1_service_absolute_total').value).to eq '26'
  end

  def check_week_1_products_total
    input_blur
    expect(find('#w1_product_total').value).to eq '25'
  end

  def go_to_week_1_tab
    page.find('#prod_serv_data_tab_1_title').click
  end

  def fill_fields
    find('#w0_service_psychology_c0').set(1)
    find('#w0_service_psychology_c1').set(12)
    find('#w0_service_plastic_surgery_c0').set(3)
    find('#w0_service_mesh_c1').set(4)
    find('#w0_product_mask').set(10)
  end

  def expect_dates_to_be_in_interval
    find_all('#index_table td.date').each do |d|
      date = Date.strptime d.text, '%m/%d/%Y'
      expect(start_date < date).to be true
      expect(date < final_date).to be true
    end
  end
end
