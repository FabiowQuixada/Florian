require 'rails_helper'

describe 'Message modal', js: true, type: :request do
  let(:bill) { Bill.first }

  it 'is closed by the user' do
    login_as_admin
    visit edit_bill_path bill
    click_on_update_btn
    find('#global_notice_box .close').click
    expect(page).to have_selector('#global_notice_box', visible: false)
  end
end
