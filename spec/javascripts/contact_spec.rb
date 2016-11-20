require 'rails_helper'

describe Contact, js: true, type: :request do
  before :each do
    login_as_admin
    visit edit_maintainer_path Maintainer.first
    page.find('#main_tab_2_title').click
  end

  it 'is added to a maintainer' do
    name, position = add_contact
    wait
    expect(all('td.contact_name').last['innerHTML']).to eq name
    expect(all('td.contact_position').last['innerHTML']).to eq position
  end

  it 'is persisted in to a maintainer' do
    name, position = add_contact
    save_and_revisit
    expect(all('td.contact_name').last['innerHTML']).to eq name
    expect(all('td.contact_position').last['innerHTML']).to eq position
  end

  it 'is edited in a maintainer' do
    contact = Maintainer.first.contacts[0]
    new_name = edit_first_contact
    expect(find("tr#contact_#{contact.id} td.contact_name")['innerHTML']).to eq new_name
  end

  it 'changes are persisted in a maintainer' do
    contact = Maintainer.first.contacts[0]
    new_name = edit_first_contact
    save_and_revisit
    expect(find("tr#contact_#{contact.id} td.contact_name")['innerHTML']).to eq new_name
  end

  it 'is deleted from a maintainer' do
    deleted_name = first('td.contact_name')['innerHTML']
    first('.remove_contact_btn').click
    save_and_revisit
    expect(first('td.contact_name')['innerHTML']).not_to eq deleted_name
  end


  # Helper methods ##################################

  def add_contact(name = Faker::Name.name, position = Faker::Name.name)
    fill_in 'temp_contact_name', with: name
    fill_in 'temp_contact_position', with: position
    fill_in 'temp_contact_email_address', with: Faker::Internet.email
    fill_in 'temp_contact_telephone', with: Faker::Number.number(11)
    fill_in 'temp_contact_celphone', with: Faker::Number.number(11)
    fill_in 'temp_contact_fax', with: Faker::Number.number(11)

    find('#add_contact_btn').click

    [name, position]
  end

  def edit_first_contact
    new_name = Faker::Name.name
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
