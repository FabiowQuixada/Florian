require 'rails_helper'

describe Company, type: :request do
  it 'adds transient donation data should display warning message when pressing back button' do
    login_as_admin

    visit edit_company_path described_class.first.id

    page.find('#main_tab_1_title').click

    fill_in 'new_donation_date', with: '01/10/2015' + "\n"
    fill_in 'new_donation_value', with: '5678'
    fill_in 'new_donation_remark', with: 'remark'

    page.find('#add_donation_btn').click

    page.find('#form_back_btn').click

    sleep(inspection_time = 1)

    expect(page).to have_content 'Dados não salvos'
  end
end
