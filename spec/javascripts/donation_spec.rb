require 'rails_helper'

describe Donation, js: true, type: :request do
  include ActionView::Helpers::NumberHelper

  before :each do
    login_as_admin
    visit edit_maintainer_path Maintainer.first
    page.find('#main_tab_1_title').click
  end

  it 'is added to a maintainer' do
    new_remark, new_value = add_donation
    expect(all('td.donation_value').last['innerHTML']).to eq number_to_currency new_value.to_f / 100
    expect(all('td.donation_remark').last['innerHTML']).to eq new_remark
  end

  it 'is persisted in a maintainer' do
    # new_remark, _new_value = add_donation
    # save_and_revisit
    # expect(all('td.donation_remark').last['innerHTML']).to eq new_remark
  end

  it 'is deleted from a maintainer' do
    remark = all('td.donation_remark').last['innerHTML']
    all('.remove_donation_btn').last.click
    save_and_revisit
    expect(all('td.donation_remark').last['innerHTML']).not_to eq remark
  end


  # Helper methods ###############################

  def add_donation
    new_remark = Faker::Lorem.paragraph
    new_value = Faker::Number.number(4)
    fill_in 'new_donation_date', with: Date.today + 100.years
    fill_in 'new_donation_value', with: new_value
    fill_in 'new_donation_remark', with: new_remark

    find('#add_donation_btn').click
    wait

    [new_remark, new_value]
  end

  def save_and_revisit
    find('.save_btn').click
    visit edit_maintainer_path Maintainer.first
    page.find('#main_tab_1_title').click
  end
end
