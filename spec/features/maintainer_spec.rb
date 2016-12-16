require 'rails_helper'

describe Maintainer, js: true, type: :request do
  before :each do
    login_as_admin
  end

  describe 'filters' do
    before :each do
      visit maintainers_path
      click_on I18n.t 'helpers.filters'
    end

    it 'filters by group' do
      select I18n.t('enums.maintainer.group.maintainer'), from: 'q_group_eq'
      click_on I18n.t 'helpers.action.apply'

      index_table = find('#index_table')
      expect(index_table).to have_content I18n.t 'enums.maintainer.group.maintainer'
      described_class.groups.each { |group| expect(index_table).not_to have_content I18n.t "enums.maintainer.group.#{group}" if group != 'maintainer' }
    end

    it 'filters by category' do
      select I18n.t('enums.maintainer.category.low'), from: 'q_category_eq'
      click_on I18n.t 'helpers.action.apply'

      index_table = find('#index_table')
      expect(index_table).to have_content I18n.t 'enums.maintainer.category.low'
      described_class.categories.each { |category| expect(index_table).not_to have_content I18n.t "enums.maintainer.category.#{category}" if category != 'low' }
    end
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
    remark = Faker::Hipster.paragraph
    add_donation remark

    click_on_update_btn
    expect_edit_page_to_have_content remark
  end

  it 'adds transient donation data should display warning message when pressing back button' do
    visit edit_maintainer_path described_class.first.id
    add_donation Faker::Hipster.paragraph

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
    select company_type, from: 'maintainer_entity_type'
    fill_in 'maintainer_registration_name', with: Faker::Company.name
    fill_in 'maintainer_cnpj', with: BlaBla::CNPJ.formatado
    fill_in 'maintainer_name', with: Faker::Company.name
    fill_in 'maintainer_address', with: Faker::Address.street_address
    select low_category, from: 'maintainer_category'
    select maintainer_group, from: 'maintainer_group'
  end

  def fill_donation_fields(remark)
    fill_in 'new_donation_date', with: Faker::Date.forward(23)
    fill_in 'new_donation_value', with: Faker::Number.number(4)
    fill_in 'new_donation_remark', with: remark
  end

  def add_donation(remark = Faker::Hacker.say_something_smart)
    page.find('#main_tab_1_title').click
    fill_donation_fields remark
    page.find('#add_donation_btn').click
  end

  def fill_contact_fields(name)
    fill_in 'temp_contact_name', with: name
  end

  def add_contact(name = Faker::Name.name)
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
