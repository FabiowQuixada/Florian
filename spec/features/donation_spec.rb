require 'rails_helper'

describe Donation, type: :request do
  it 'add donation to company through new donation screen' do
    login_as_admin

    visit new_donation_path

    fill_in 'Data', with: '01/10/2015'
    fill_in 'Valor', with: '1234'
    select(Company.where(group: Company.groups[:Mantenedora]).first.name, from: 'donation_company_id')

    click_on 'Salvar'

    expect(page).to have_content'sucesso'
  end

  it 'add donation and prepare to add another' do
    login_as_admin

    visit new_donation_path

    fill_in 'Data', with: '01/10/2015'
    fill_in 'Valor', with: '1234'
    select(Company.where(group: Company.groups[:Mantenedora]).first.name, from: 'donation_company_id')

    click_on 'Salvar e cadastrar nova'

    expect(page).to have_content'sucesso'
  end

  it 'add donation to company through company screen' do
    login_as_admin

    visit edit_company_path Company.first.id

    remark = 'observacao ' + Time.new.usec.to_s

    page.find('#main_tab_1_title').click

    fill_in 'new_donation_date', with: '01/10/2015' + "\n"
    fill_in 'new_donation_value', with: '5678'
    fill_in 'new_donation_remark', with: remark

    page.find('#add_donation_btn').click

    visit edit_company_path Company.first.id

    page.all('tr.transient_donation').each do |tr|
      tr.should have_content(remark)
    end
  end
end