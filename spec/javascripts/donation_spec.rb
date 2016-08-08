require 'rails_helper'

# rubocop:disable all
describe Donation, type: :request do
  before :each do
    login_as_admin
    visit edit_company_path Company.first
    page.find('#main_tab_1_title').click
  end

  it 'adds a donation to an entity' do
    remark = 'lalaa'
    fill_donation_fields(remark)

    find('#add_donation_btn').click

    wait

    expect(all('td.donation_value').last['innerHTML']).to eq 'R$ 56,78'
    expect(all('td.donation_remark').last['innerHTML']).to eq remark

    find('.save_btn').click
    visit edit_company_path Company.first
    page.find('#main_tab_1_title').click

    expect(all('td.donation_remark').last['innerHTML']).to eq remark
  end

  it 'deletes a donation from an entity' do
    remark = all('td.donation_remark').last['innerHTML']

    all('.remove_donation_btn').last.click

    find('.save_btn').click
    visit edit_company_path Company.first
    page.find('#main_tab_1_title').click

    expect(all('td.donation_remark').last['innerHTML']).not_to eq remark
  end


  # Helper methods ###############################

  def fill_donation_fields(remark)
    fill_in 'new_donation_date', with: '01/10/2050' + "\n"
    fill_in 'new_donation_value', with: '5678'
    fill_in 'new_donation_remark', with: remark
  end
end
# rubocop:enable all