require 'rails_helper'

describe User, js: true, type: :request do
  let(:signature) { 'lalala' }
  let(:re_title) { 're #competencia lalala' }
  let(:pse_title) { 'pse #competencia lalala' }

  it 'is not allowed to login if it is not active' do
    visit root_path
    try_to_login_as_inactive_user
    expect_deactivated_msg
  end

  describe 'as admin' do
    before :each do
      login_as_admin
    end

    it 'adds a new user' do
      visit new_user_path
      fill_new_fields
      click_on_save_btn
      expect_success_msg
    end

    it 'updates profile info' do
      visit edit_user_registration_path
      fill_admin_profile_fields
      fill_settings_fields
      click_on_update_btn
      check_if_changes_persisted
    end
  end

  describe 'as common user' do
    before :each do
      login_as_common_user
    end

    it 'tries to add a new user' do
      visit new_user_path
      expect_access_denied_msg
    end

    it 'tries to edit another user' do
      visit edit_user_path non_logged_user
      expect_access_denied_msg
    end

    it 'updates profile info' do
      visit edit_user_registration_path
      fill_common_user_profile_fields
      click_on_update_btn
      visit edit_user_registration_path
      expect(first('#user_signature').value).to eq signature
    end

    it 'language is changed' do
      visit edit_user_registration_path
      select I18n.t('locale.pt-BR'), from: 'user_locale'
      fill_in i18n_field('current_password'), with: 'usuario_comum'
      click_on_update_btn
      expect(page).to have_content 'Sua conta foi atualizada com sucesso.'
    end
  end

  it '#active_for_authentication?' do
    user = build :user
    expect(user.active_for_authentication?).to be true
    user.active = false
    expect(user.active_for_authentication?).to be false
  end

  it '#guest?' do
    user = build :user, :guest
    expect(user.guest?).to be true

    user = build :user
    expect(user.guest?).to be false
  end


  # == Helper methods =============================================================

  def fill_new_fields
    name_field = I18n.t('activerecord.attributes.user.name')
    email_field = I18n.t('activerecord.attributes.user.email')
    password_field = I18n.t('activerecord.attributes.user.password')
    confirm_pass_field = I18n.t('activerecord.attributes.user.password_confirmation')
    group_field = I18n.t('activerecord.attributes.user.role')

    fill_in name_field, with: Faker::Name.name
    fill_in email_field, with: Faker::Internet.email
    fill_in password_field, with: 'fulano0123'
    fill_in confirm_pass_field, with: 'fulano0123'
    select 'Usuário', from: group_field
  end

  def fill_admin_profile_fields
    fill_in i18n_field('signature'), with: signature
    fill_in i18n_field('current_password'), with: 'fulano0123'
  end

  def fill_common_user_profile_fields
    signature_field = i18n_field 'signature'
    cur_pass_field = i18n_field 'current_password'

    fill_in signature_field, with: signature
    fill_in cur_pass_field, with: 'usuario_comum'
  end

  def try_to_login_as_inactive_user
    fill_login_fields_with 'teste_inativo@yahoo.com.br', 'usuario_teste'
    click_on_login_btn
  end

  def fill_settings_fields
    page.find('#main_tab_1_title').click
    # first('#user_system_setting_re_title').set re_title

    page.find('#main_tab_2_title').click
    first('#user_system_setting_pse_title').set pse_title
  end

  def check_if_changes_persisted
    visit edit_user_registration_path
    check_general_tab
    # check_receipt_tab
    check_prod_serv_tab
  end

  def check_general_tab
    expect(first('#user_signature').value).to eq signature
  end

  def check_receipt_tab
    page.find('#main_tab_1_title').click
    expect(first('#user_system_setting_re_title').value).to eq re_title
  end

  def check_prod_serv_tab
    page.find('#main_tab_2_title').click
    expect(first('#user_system_setting_pse_title').value).to eq pse_title
  end

  def expect_deactivated_msg
    expect(page).to have_content 'inativada' if I18n.locale == :"pt-BR"
    expect(page).to have_content 'not activated yet' if I18n.locale == :en
  end
end
