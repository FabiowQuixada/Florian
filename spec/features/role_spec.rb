require 'rails_helper'

describe Role, js: true, type: :request do
  context 'as admin' do
    before :each do
      login_as_admin
    end

    context 'index' do
      before :each do
        visit roles_path
      end

      describe 'filters' do
        before :each do
          click_on I18n.t 'helpers.filters'
        end

        it 'by name' do
          name = described_class.first.name
          fill_in :q_name_cont, with: name
          click_on I18n.t 'helpers.action.apply'

          find_all('#index_table td.role_name').each { |m| expect(m.text).to eq name }
          expect_info_msg_to_include 'found'
        end
      end
    end

    it 'adds a new role' do
      visit new_role_path
      fill_form
      click_on_save_btn
      expect_success_msg
    end

    it 'updates role' do
      visit edit_role_path described_class.first
      change_field 'description', 'lala'
      click_on_update_btn
      visit edit_role_path described_class.first
      expect(first('#role_description').value).to eq 'lala'
    end
  end

  context 'as common user' do
    before :each do
      login_as_common_user
    end

    it 'tries to add a new role' do
      visit new_role_path
      expect_access_denied_msg
    end

    it 'updates role' do
      visit edit_role_path described_class.first
      expect_access_denied_msg
    end
  end


  # == Helper methods =============================================================

  def fill_form
    fill_in i18n_field('name'), with: Faker::Team.name
    fill_in i18n_field('description'), with: Faker::Lorem.paragraph
  end

  def change_field(field_name, value)
    fill_in i18n_field(field_name), with: value
  end
end
