require 'rails_helper'

describe User, js: true, type: :request do
  let(:signature) { 'lalala' }

  it 'is not allowed to login if it is not active' do
    visit root_path
    try_to_login_as_inactive_user
    expect_deactivated_msg
  end

  describe 'as admin' do
    before :each do
      login_as_admin
    end

    context 'index' do
      before :each do
        visit users_path
      end

      describe 'filters' do
        before :each do
          click_on I18n.t 'helpers.filters'
        end

        it 'by name' do
          name = described_class.first.name
          fill_in :q_name_cont, with: name
          click_on I18n.t 'helpers.action.apply'

          find_all('#index_table td.user_name').each { |m| expect(m.text).to eq name }
          expect_info_msg_to_include 'found'
        end

        it 'by group' do
          name = Role.first.name
          select name, from: 'q_role_id_eq'
          click_on I18n.t 'helpers.action.apply'

          find_all('#index_table td.user_role').each { |m| expect(m.text).to eq name }
          expect_info_msg_to_include 'found'
        end
      end
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
      fill_locale_data
      click_on_update_btn
      expect(page).to have_content 'Sua conta foi atualizada com sucesso.'
      set_locale_back
    end

    it 'logs out' do
      find('.profile-area.hidden-xs .logout-btn').click
      expect_success_msg
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
  def fill_locale_data
    select I18n.t('locale.pt-BR'), from: 'user_locale'
    fill_in i18n_field('current_password'), with: 'usuario_comum'
  end

  def set_locale_back
    visit edit_user_registration_path
    select I18n.t('locale.en'), from: 'user_locale'
    fill_in 'Senha atual', with: 'usuario_comum'
    click_on 'Atualizar'
  end

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

  def check_if_changes_persisted
    visit edit_user_registration_path
    expect(first('#user_signature').value).to eq signature
  end

  def expect_deactivated_msg
    expect(page).to have_content 'inativada' if I18n.locale == :"pt-BR"
    expect(page).to have_content 'not activated yet' if I18n.locale == :en
  end
end
