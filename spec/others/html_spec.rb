require 'rails_helper'

describe 'HTML', type: :request do
  MENU_MODELS = [Company, Donation, ReceiptEmail, ProductAndServiceDatum, Bill, SystemSetting, User, Role].freeze

  it 'has consistent login html code' do
    visit new_user_session_path
    expect(page).to have_valid_html
  end

  describe 'when logged in' do
    before :each do
      login_as_admin
    end

    it 'has consistent root html code' do
      visit root_path
      expect(page).to have_valid_html
    end

    it 'has consistent user profile html code' do
      visit edit_user_registration_path
      expect(page).to have_valid_html
    end

    it 'has consistent index html code' do
      MENU_MODELS.each do |model|
        visit send model.model_name.route_key + '_path'
        expect(page).to have_valid_html
      end
    end

    it 'has consistent new html code' do
      MENU_MODELS.each do |model|
        next if model == SystemSetting
        visit send 'new_' + model.name.underscore + '_path'
        expect(page).to have_valid_html
      end
    end

    it 'has consistent edit html code' do
      MENU_MODELS.each do |model|
        visit send 'edit_' + model.name.underscore + '_path', model.first
        expect(page).to have_valid_html
      end
    end
  end
end
