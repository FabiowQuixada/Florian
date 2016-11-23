require 'rails_helper'

describe Donation, type: :request do
  include LocaleHelper

  before :each do
    login_as_admin
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
end
