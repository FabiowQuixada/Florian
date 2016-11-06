require 'rails_helper'

describe Donation, type: :request do
  include LocaleHelper

  before :each do
    login_as_admin
  end

  it 'add donation to maintainer through new donation screen' do
    visit new_donation_path
    fill_fields
    click_on_save_btn
    expect_success_msg
  end

  it 'add donation and prepare to add another' do
    visit new_donation_path
    fill_fields

    click_on_save_and_new_btn
    expect_success_msg
  end

  it 'display only `maintainer` group maintainers' do
    visit new_donation_path
    expect(page).to have_select I18n.t('activerecord.models.maintainer.one'), with_options: Maintainer.where(group: 'maintainer').each.map(&:name)
  end

  # == Helper methods =============================================================

  def fill_fields
    fill_in i18n_field('donation_date'), with: Faker::Date.forward(23)
    fill_in i18n_field('value'), with: Faker::Number.number(4)
    select(Maintainer.where(group: 'maintainer').first.name, from: 'donation_maintainer_id')
    input_blur
  end

  def click_on_save_and_new_btn
    click_on genderize_full_tag(described_class.new, 'helpers.action.update_and_new')
  end
end
