require 'rails_helper'

describe Donation, js: true, type: :request do
  before :each do
    login_as_admin
    visit edit_maintainer_path Maintainer.first
    page.find('#main_tab_1_title').click
  end

  it 'adds a donation to a maintainer' do
    new_remark = add_donation
    expect(all('td.donation_value').last['innerHTML']).to eq 'R$ 56,78'
    expect(all('td.donation_remark').last['innerHTML']).to eq new_remark
    save_and_revisit
    expect(all('td.donation_remark').last['innerHTML']).to eq new_remark
  end

  it 'deletes a donation from a maintainer' do
    remark = all('td.donation_remark').last['innerHTML']
    all('.remove_donation_btn').last.click
    save_and_revisit
    expect(all('td.donation_remark').last['innerHTML']).not_to eq remark
  end


  # Helper methods ###############################

  def add_donation
    new_remark = Time.now.to_s
    fill_in 'new_donation_date', with: "01/10/2050\n"
    fill_in 'new_donation_value', with: '5678'
    fill_in 'new_donation_remark', with: new_remark

    find('#add_donation_btn').click
    wait

    new_remark
  end

  def save_and_revisit
    find('.save_btn').click
    visit edit_maintainer_path Maintainer.first
    page.find('#main_tab_1_title').click
  end
end
