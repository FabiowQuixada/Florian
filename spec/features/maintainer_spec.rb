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

    describe 'by group' do
      before :each do
        select I18n.t('enums.maintainer.group.maintainer'), from: 'q_group_eq'
        click_on I18n.t 'helpers.action.apply'
      end

      it { expect_info_msg_to_include 'found' }

      it '' do
        index_table = find('#index_table')
        expect(index_table).to have_content I18n.t 'enums.maintainer.group.maintainer'
      end

      it '' do
        index_table = find('#index_table')
        described_class.groups.each do |group|
          expect(index_table).not_to have_content I18n.t "enums.maintainer.group.#{group}" if group != 'maintainer'
        end
      end
    end

    describe 'by category' do
      before :each do
        select I18n.t('enums.maintainer.category.low'), from: 'q_category_eq'
        click_on I18n.t 'helpers.action.apply'
      end

      it { expect_info_msg_to_include 'found' }

      it 'displays `low` category' do
        index_table = find('#index_table')
        expect(index_table).to have_content I18n.t 'enums.maintainer.category.low'
      end

      it 'displays no category other than `low`' do
        index_table = find('#index_table')
        described_class.categories.each do |category|
          expect(index_table).not_to have_content I18n.t "enums.maintainer.category.#{category}" if category != 'low'
        end
      end
    end
  end

  describe 'new' do
    before do
      visit new_maintainer_path
      fill_main_fields
    end

    it 'persists a maintainer with a contact' do
      add_contact
      click_on_save_btn
      expect_success_msg
    end

    it 'persists a maintainer with a donation' do
      add_donation
      click_on_save_btn
      expect_success_msg
    end
  end

  describe 'edit' do
    let(:maintainer) { described_class.first }

    before do
      visit edit_maintainer_path maintainer
    end

    it 'displays "no contacts" message when all contacts are deleted' do
      page.find('#main_tab_2_title').click

      # Workaround
      maintainer.contacts.length.times { first('#contact_area .remove_btn').click }
      expect(page).to have_content 'No contacts found.'
    end

    describe 'donation' do
      before :each do
        visit edit_maintainer_path described_class.first
        page.find('#main_tab_1_title').click
      end

      it 'adds transient donation data should display warning message when pressing back button' do
        add_donation Faker::Hipster.paragraph

        go_back
        expect(page).to have_content I18n.t('modal.title.back')
      end

      it 'persists donation' do
        remark = Faker::Hipster.paragraph
        add_donation remark

        click_on_update_btn
        expect_edit_page_to_have_content remark
      end

      it 'displays "no donations" message when all donations are deleted' do
        # Workaround
        maintainer.donations.length.times { first('#donation_area .hidden-xs > .remove_btn').click }
        expect(page).to have_content 'No donations found.'
      end

      it 'is deleted from a maintainer' do
        remark = all('td.donation_remark').last['innerHTML']
        all('.remove_btn').last.click
        save_and_revisit
        expect(all('td.donation_remark').last['innerHTML']).not_to eq remark
      end
    end
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
    fill_in 'maintainer_cnpj', with: BlaBla::CNPJ.numero
    fill_in 'maintainer_name', with: Faker::Company.name
    fill_in 'maintainer_address', with: Faker::Address.street_address
    select low_category, from: 'maintainer_category'
    select maintainer_group, from: 'maintainer_group'
  end

  def fill_donation_fields(remark)
    find('#donation_donation_date_group input.temp_field').set I18n.localize(Faker::Date.forward(23))
    fill_in 'donation_value', with: Faker::Number.number(4)
    fill_in 'donation_remark', with: remark
    execute_script('$(".datepicker-dropdown").hide()')
  end

  def add_donation(remark = Faker::Hacker.say_something_smart)
    page.find('#main_tab_1_title').click
    within '#donation_area' do
      fill_donation_fields remark
      page.find('.add-btn').click
    end
  end

  def fill_contact_fields(name)
    fill_in 'contact_name', with: name
  end

  def add_contact(name = Faker::Name.name)
    page.find('#main_tab_2_title').click
    within '#contact_area' do
      fill_contact_fields name
      page.find('.add-btn').click
    end
  end

  def expect_edit_page_to_have_content(remark)
    visit edit_maintainer_path described_class.first.id

    page.all('tr.transient_donation').each do |tr|
      tr.should have_content(remark)
    end
  end

  def save_and_revisit
    find('.save_btn').click
    visit edit_maintainer_path Maintainer.first
    page.find('#main_tab_1_title').click
  end
end
