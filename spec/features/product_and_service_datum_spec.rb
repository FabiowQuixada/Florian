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

    it 'filters by date' do
      fill_in 'aux_competence_gteq', with: start
      fill_in 'aux_competence_lteq', with: final
      click_on I18n.t 'helpers.action.apply'

      expect(page).not_to have_content I18n.t('errors.messages.invalid_period_i')
      expect_dates_to_be_in_interval
    end

    it 'displays message if the period is invalid' do
      fill_in 'aux_competence_gteq', with: final
      fill_in 'aux_competence_lteq', with: start
      click_on I18n.t 'helpers.action.apply'

      expect(page).to have_content I18n.t('errors.messages.invalid_period_i')
    end
  end

  context 'is persisted' do
    let(:prefix) { 'input#product_and_service_datum_product_and_service_weeks_attributes_' }

    before :each do
      login_as_admin
      visit new_product_and_service_datum_path
      fill_fields
      click_on_save_btn
      visit edit_product_and_service_datum_path described_class.last
    end

    it { expect(first("#{prefix}0_service_data_attributes_0_psychology").value).to eq '1' }
    it { expect(first("#{prefix}0_service_data_attributes_1_psychology").value).to eq '12' }
    it { expect(first("#{prefix}0_service_data_attributes_0_plastic_surgery").value).to eq '3' }
    it { expect(first("#{prefix}0_service_data_attributes_1_mesh").value).to eq '4' }
    it { expect(first("#{prefix}0_product_data_attributes_mask").value).to eq '10' }

    def fill_fields
      first("#{prefix}0_service_data_attributes_0_psychology").set(1)
      first("#{prefix}0_service_data_attributes_1_psychology").set(12)
      first("#{prefix}0_service_data_attributes_0_plastic_surgery").set(3)
      first("#{prefix}0_service_data_attributes_1_mesh").set(4)
      first("#{prefix}0_product_data_attributes_mask").set(10)
    end
  end

  def expect_dates_to_be_in_interval
    find_all('#index_table td.date').each do |d|
      date = Date.strptime d.text, '%m/%d/%Y'
      expect(start_date < date).to be true
      expect(date < final_date).to be true
    end
  end
end
