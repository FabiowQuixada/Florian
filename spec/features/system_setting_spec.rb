require 'rails_helper'

describe SystemSetting, type: :request do
  let(:title) { 'Recibo de Doação IAQ #mantenedora - #competencia lalala' }

  describe 'as admin' do
    before :each do
      login_as_admin
    end

    it 'updates profile info' do
      visit edit_system_setting_path logged_user.system_setting
      fill_fields
      click_on 'Atualizar'
      visit edit_system_setting_path logged_user.system_setting
      expect(first('#system_setting_re_title').value).to eq title
    end

    it 'updates a user setting' do
      visit edit_system_setting_path non_logged_user.system_setting
      fill_fields
      click_on 'Atualizar'
      visit edit_system_setting_path non_logged_user.system_setting
      expect(first('#system_setting_re_title').value).to eq title
    end
  end

  describe 'as common user' do
    before :each do
      login_as_common_user
    end

    it 'tries to edit other user`s system setting' do
      visit edit_system_setting_path non_logged_user.system_setting
      expect(page).to have_content I18n.t('error_pages.not_found.title')
    end

    it 'updates own config info' do
      visit system_settings_path
      fill_fields
      click_on 'Atualizar'
      expect(page).to have_content 'sucesso'
    end
  end


  # == Helper methods =============================================================

  def fill_fields
    fill_in 'Título', with: title
  end
end
