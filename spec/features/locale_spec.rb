require 'rails_helper'

describe 'Locale', type: :request do
  LOCALE_DATA = [Maintainer, Donation, ReceiptEmail, ProductAndServiceDatum, Bill, User, Role].freeze

  it 'contains no translation missing on login page' do
    visit root_path
    expect(page).to have_no_content 'translation_missing'
  end

  context 'logged in' do
    before :each do
      login_as_admin
    end

    it 'contains no translation missing on index page' do
      LOCALE_DATA.each do |data|
        visit send("#{data.model_name.route_key}_path")
        expect(page).to have_no_content('translation_missing'), data.name
      end
    end

    it 'contains no translation missing on new page' do
      LOCALE_DATA.each do |data|
        visit send("new_#{data.name.singularize.underscore}_path")
        expect(page).to have_no_content('translation_missing'), data.name
      end
    end

    it 'contains no translation missing on edit page' do
      LOCALE_DATA.each do |data|
        visit send("edit_#{data.name.singularize.underscore}_path", data.first)
        expect(page).to have_no_content('translation_missing'), data.name
      end
    end
  end
end
