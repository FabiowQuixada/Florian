require 'rails_helper'

describe Bill, js: true, type: :request do
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
