require 'rails_helper'

# rubocop:disable all
describe Contact, type: :request do
  before :each do
    login_as_admin
    visit edit_company_path Company.first
    page.find('#main_tab_2_title').click
  end

  it 'adds a contact to an entity' do
    fill_contact_fields

    find('#add_contact_btn').click

    wait

    expect(all('td.contact_name').last['innerHTML']).to eq 'Joao'
    expect(all('td.contact_position').last['innerHTML']).to eq 'Chefe'

    find('.save_btn').click
    visit edit_company_path Company.first
    page.find('#main_tab_2_title').click


    expect(all('td.contact_name').last['innerHTML']).to eq 'Joao'
  end

  it 'loads and updates a contact in a entity' do
    contact = Company.first.contacts[0]
    first('.edit_contact_btn').click

    new_name = contact.name + ' novo'

    expect(find('#temp_contact_name').value).to eq contact.name

    fill_in 'temp_contact_name', with: new_name

    find('#add_contact_btn').click

    expect(find('tr#contact_' + contact.id.to_s + ' td.contact_name')['innerHTML']).to eq new_name

    find('.save_btn').click

    visit edit_company_path Company.first
    page.find('#main_tab_2_title').click

    expect(find('tr#contact_' + contact.id.to_s + ' td.contact_name')['innerHTML']).to eq new_name
  end

  it 'deletes a contact from an entity' do
  end


  # Helper methods ##################################

  def fill_contact_fields
    fill_in 'temp_contact_name', with: 'Joao'
    fill_in 'temp_contact_position', with: 'Chefe'
    fill_in 'temp_contact_email_address', with: 'exemplo@gmail.com'
    fill_in 'temp_contact_telephone', with: '85325756158'
    fill_in 'temp_contact_celphone', with: '85325756158'
    fill_in 'temp_contact_fax', with: '85325756158'
  end
end
# rubocop:enable all