require 'rails_helper'

describe Maintainer, js: true, type: :request do
  before :each do
    login_as_admin
  end

  it 'persists a maintainer with a contact' do
    visit new_maintainer_path
    fill_main_fields
    add_contact

    click_on 'Salvar'
    expect(page).to have_content 'sucesso'
  end

  it 'persists a maintainer with a donation' do
    visit new_maintainer_path
    fill_main_fields
    add_donation

    click_on 'Salvar'
    expect(page).to have_content 'sucesso'
  end

  it 'persists donation' do
    visit edit_maintainer_path described_class.first.id
    remark = "observacao #{Time.new.usec}"
    add_donation remark
    click_on 'Atualizar'

    expect_edit_page_to_have_content remark
  end

  it 'adds transient donation data should display warning message when pressing back button' do
    visit edit_maintainer_path described_class.first.id
    add_donation 'remark'

    go_back

    expect(page).to have_content 'Dados não salvos'
  end

  # == Helper methods =============================================================

  def fill_main_fields
    time = Time.new.usec
    select 'Pessoa Jurídica', from: 'maintainer_entity_type'
    fill_in 'maintainer_registration_name', with: "Maintainer #{time}"
    fill_in 'maintainer_cnpj', with: BlaBla::CNPJ.formatado
    fill_in 'maintainer_name', with: "Maintainer #{time}"
    fill_in 'maintainer_address', with: "Maintainer address #{time}"
    select '1 (Abaixo de R$ 300,00)', from: 'maintainer_category'
    select 'Mantenedora', from: 'maintainer_group'
  end

  def fill_donation_fields(remark)
    fill_in 'new_donation_date', with: "01/10/2015\n"
    fill_in 'new_donation_value', with: '5678'
    fill_in 'new_donation_remark', with: remark
  end

  def add_donation(remark = "Observacao #{Time.new.usec}")
    page.find('#main_tab_1_title').click
    fill_donation_fields remark
    page.find('#add_donation_btn').click
  end

  def fill_contact_fields(name)
    fill_in 'temp_contact_name', with: name
  end

  def add_contact(name = "Contato #{Time.new.usec}")
    page.find('#main_tab_2_title').click
    fill_contact_fields name
    page.find('#add_contact_btn').click
  end

  def expect_edit_page_to_have_content(remark)
    visit edit_maintainer_path described_class.first.id

    page.all('tr.transient_donation').each do |tr|
      tr.should have_content(remark)
    end
  end
end
