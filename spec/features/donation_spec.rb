require 'rails_helper'

describe Donation, type: :request do
  before :each do
    login_as_admin
  end

  it 'add donation to company through new donation screen' do
    visit new_donation_path
    fill_fields
    click_on 'Salvar'
    expect(page).to have_content 'sucesso'
  end

  it 'add donation and prepare to add another' do
    visit new_donation_path
    fill_fields

    click_on 'Salvar e cadastrar nova'
    expect(page).to have_content'sucesso'
  end

  it 'display only `maintainer` group maintainers' do
    visit new_donation_path
    expect(page).to have_select 'Mantenedora', with_options: Company.where(group: 'maintainer').each.map(&:name)
  end

  # == Helper methods =============================================================

  def fill_fields
    fill_in 'Data', with: '01/10/2015'
    fill_in 'Valor', with: '1234'
    select(Company.where(group: 'maintainer').first.name, from: 'donation_company_id')
    input_blur
  end
end
