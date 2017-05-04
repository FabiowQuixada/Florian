require 'rails_helper'

describe 'Admin Info', js: true, type: :request do
  before :each do
    login_as_admin
    visit edit_product_and_service_datum_path ProductAndServiceDatum.last
  end

  it 'is displayed if admin-icon is clicked' do
    find('.profile-area.hidden-xs .admin_key_btn').click
    expect(page).to have_selector('#product_and_service_datum_id', visible: true)
  end

  it 'is not displayed by default' do
    expect(page).to have_selector('#product_and_service_datum_id', visible: false)
  end
end
