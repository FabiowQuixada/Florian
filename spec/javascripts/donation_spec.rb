require 'rails_helper'

describe Donation, type: :request do
  before :each do
    login_as_admin
    visit edit_company_path Company.first
    page.find('#main_tab_1_title').click
  end
end
