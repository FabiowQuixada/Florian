require 'rails_helper'

describe Contact, js: true, type: :request do
  before :each do
    login_as_admin
    visit edit_maintainer_path Maintainer.first
    page.find('#main_tab_2_title').click
  end

  it 'adds a contact to a maintainer' do
    add_contact 'Joao'
    expect(all('td.contact_name').last['innerHTML']).to eq 'Joao'
    expect(all('td.contact_position').last['innerHTML']).to eq 'Chefe'

    save_and_revisit
    expect(all('td.contact_name').last['innerHTML']).to eq 'Joao'
  end

  it 'loads and updates a contact in a maintainer' do
    contact = Maintainer.first.contacts[0]
    new_name = edit_first_contact

    expect(find("tr#contact_#{contact.id} td.contact_name")['innerHTML']).to eq new_name
    save_and_revisit
    expect(find("tr#contact_#{contact.id} td.contact_name")['innerHTML']).to eq new_name
  end

  it 'deletes a contact from a maintainer' do
    deleted_name = first('td.contact_name')['innerHTML']
    first('.remove_contact_btn').click
    save_and_revisit
    expect(first('td.contact_name')['innerHTML']).not_to eq deleted_name
  end


  # Helper methods ##################################

  def add_contact(name)
    fill_in 'temp_contact_name', with: name
    fill_in 'temp_contact_position', with: 'Chefe'
    fill_in 'temp_contact_email_address', with: 'exemplo@gmail.com'
    fill_in 'temp_contact_telephone', with: '85325756158'
    fill_in 'temp_contact_celphone', with: '85325756158'
    fill_in 'temp_contact_fax', with: '85325756158'

    find('#add_contact_btn').click
  end

  def edit_first_contact
    new_name = "Contato #{Time.now}"
    first('.edit_contact_btn').click
    fill_in 'temp_contact_name', with: new_name
    find('#add_contact_btn').click

    new_name
  end

  def save_and_revisit
    find('.save_btn').click
    visit edit_maintainer_path Maintainer.first
    page.find('#main_tab_2_title').click
  end
end
