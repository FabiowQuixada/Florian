require 'rails_helper'

describe Maintainer, js: true, type: :request do
  before :each do
    login_as_admin
  end

  it 'persists a maintainer with a contact' do
    visit new_maintainer_path
    fill_main_fields
    add_contact

    click_on_save_btn
    expect_success_msg
  end

  it 'persists a maintainer with a donation' do
    visit new_maintainer_path
    fill_main_fields
    add_donation

    click_on_save_btn
    expect_success_msg
  end

  it 'persists donation' do
    visit edit_maintainer_path described_class.first.id
    remark = "observacao #{Time.new.usec}"
    add_donation remark

    click_on_update_btn
    expect_edit_page_to_have_content remark
  end

  it 'adds transient donation data should display warning message when pressing back button' do
    visit edit_maintainer_path described_class.first.id
    add_donation 'remark'

    go_back
    expect(page).to have_content I18n.t('modal.title.back')
  end

  # == Helper methods =============================================================

  def fill_main_fields
    company_type = I18n.t('enums.maintainer.entity_type.company')
    low_category = I18n.t('enums.maintainer.category.low')
    maintainer_group = I18n.t('enums.maintainer.group.maintainer')

    fill_main_fields_with company_type, low_category, maintainer_group
  end

  def fill_main_fields_with(company_type, low_category, maintainer_group)
    time = Time.new.usec

    select company_type, from: 'maintainer_entity_type'
    fill_in 'maintainer_registration_name', with: "Maintainer #{time}"
    fill_in 'maintainer_cnpj', with: BlaBla::CNPJ.formatado
    fill_in 'maintainer_name', with: "Maintainer #{time}"
    fill_in 'maintainer_address', with: "Maintainer address #{time}"
    select low_category, from: 'maintainer_category'
    select maintainer_group, from: 'maintainer_group'
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
