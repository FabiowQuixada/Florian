require 'rails_helper'

describe 'Locale', type: :request do
  DATA = [Company, Donation, ReceiptEmail, ProductAndServiceDatum, User, Role].freeze

  before :each do
    login_as_admin
  end

  it 'contains no translation missing' do
    DATA.each do |data|
      visit send(data.model_name.route_key + '_path')
      expect(page).to have_no_content('translation_missing'), data
    end
  end

  it 'contains no translation missing' do
    DATA.each do |data|
      next unless data.new.insertable

      visit send('new_' + data.name.singularize.underscore + '_path')

      expect(page).to have_no_content('translation_missing'), data
    end
  end
end
