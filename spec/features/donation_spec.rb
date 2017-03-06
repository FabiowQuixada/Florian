require 'rails_helper'

describe Donation, js: true, type: :request do
  include ActionView::Helpers::NumberHelper
  include LocaleHelper

  before :each do
    login_as_admin
  end

  describe 'index' do
    describe 'filters' do
      let(:start) { '01/02/2016' }
      let(:final) { '06/03/2016' }
      let(:start_date) { Date.strptime start, '%m/%d/%Y' }
      let(:end_date) { Date.strptime final, '%m/%d/%Y' }

      before :each do
        visit donations_path
        click_on I18n.t 'helpers.filters'
      end

      it 'filters by maintainer' do
        name = Maintainer.first.name
        select name, from: 'q_maintainer_id_eq'
        click_on I18n.t 'helpers.action.apply'

        find_all('#index_table td.maintainer_name').each { |m| expect(m.text).to eq name }
      end

      it 'filters by date' do
        fill_in 'q_donation_date_gteq', with: start
        fill_in 'q_donation_date_lteq', with: final
        click_on I18n.t 'helpers.action.apply'

        expect(page).not_to have_content I18n.t('errors.messages.invalid_period_i')
        expect_dates_to_be_in_interval
      end

      it 'displays message if the period is invalid' do
        fill_in 'q_donation_date_gteq', with: final
        fill_in 'q_donation_date_lteq', with: start
        click_on I18n.t 'helpers.action.apply'

        expect(page).to have_content I18n.t('errors.messages.invalid_period_i')
      end
    end
  end

  describe 'form' do
    before :each do
      visit edit_maintainer_path Maintainer.first
      page.find('#main_tab_1_title').click
    end

    it 'is added to maintainer through new donation screen' do
      visit new_donation_path
      fill_fields
      click_on_save_btn
      expect_success_msg
    end

    it 'is `persisted` with no maintainer' do
      visit new_donation_path
      fill_fields false
      click_on_save_btn
      expect(page).to have_content described_class.new.blank_error_message 'maintainer'
    end

    it 'is added and new donation screen is loaded' do
      visit new_donation_path
      fill_fields
      click_on_save_and_new_btn
      expect_success_msg
    end

    it 'is added to a maintainer' do
      new_remark, new_value = add_donation
      expect(all('td.donation_value').last['innerHTML']).to eq number_to_currency new_value.to_f / 100
      expect(all('td.donation_remark').last['innerHTML']).to eq new_remark
    end

    it 'is persisted in a maintainer' do
      # new_remark, _new_value = add_donation
      # save_and_revisit
      # expect(all('td.donation_remark').last['innerHTML']).to eq new_remark
    end

    it 'is deleted from a maintainer' do
      remark = all('td.donation_remark').last['innerHTML']
      all('.remove_donation_btn').last.click
      save_and_revisit
      expect(all('td.donation_remark').last['innerHTML']).not_to eq remark
    end
  end

  # == Helper methods =============================================================

  def fill_fields(fill_maintainer = true)
    fill_in i18n_field('donation_date'), with: Faker::Date.forward(23)
    fill_in i18n_field('value'), with: Faker::Number.number(4)
    select(Maintainer.where(group: 'maintainer').first.name, from: 'donation_maintainer_id') if fill_maintainer
    input_blur
  end

  def click_on_save_and_new_btn
    click_on genderize_full_tag(described_class.new, 'helpers.action.update_and_new')
  end

  def expect_dates_to_be_in_interval
    find_all('#index_table td.date').each do |d|
      date = Date.strptime d.text, '%m/%d/%Y'
      expect(start_date < date).to be true
      expect(date < final_date).to be true
    end
  end

  def add_donation
    new_remark = Faker::Lorem.paragraph
    new_value = Faker::Number.number(4)
    fill_in 'new_donation_date', with: Date.today + 100.years
    fill_in 'new_donation_value', with: new_value
    fill_in 'new_donation_remark', with: new_remark

    find('#add_donation_btn').click
    wait

    [new_remark, new_value]
  end

  def save_and_revisit
    find('.save_btn').click
    visit edit_maintainer_path Maintainer.first
    page.find('#main_tab_1_title').click
  end
end
