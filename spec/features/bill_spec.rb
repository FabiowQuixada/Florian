require 'rails_helper'

describe Bill, js: true, type: :request do
  describe 'index' do
    describe 'filters' do
      let(:start) { '02/2016' }
      let(:final) { '06/2016' }

      before :each do
        login_as_admin
        visit bills_path
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

    def expect_dates_to_be_in_interval
      find_all('#index_table td.date').each do |d|
        date = Date.strptime d.text, '%m/%d/%Y'
        expect(start_date < date).to be true
        expect(date < final_date).to be true
      end
    end
  end

  describe 'form' do
    let(:bill) { described_class.first }

    before :each do
      login_as_admin
      visit edit_bill_path bill
    end

    it 'updates totals field properly' do
      fill_fields
      input_blur
      expect(first('#bill_totals').value).to eq '2,999,999.97'
    end

    it { expect(first('#bill_totals').value).to eq ActionController::Base.helpers.number_to_currency(bill.total.to_f, unit: '') }
  end

  # Helper methods ###################################

  def fill_fields
    first('#bill_water').set(99_999_999)
    first('#bill_energy').set(99_999_999)
    first('#bill_telephone').set(99_999_999)
  end
end
