require 'rails_helper'

describe User, type: :request do
  let(:signature) { 'lalala' }

  it 'is not allowed to login if it is not active' do
    visit root_path
    try_to_login_as_inactive_user
    expect(page).to have_content 'inativada'
  end

  describe 'as admin' do
    before :each do
      login_as_admin
    end

    it 'adds a new user' do
      visit new_user_path
      fill_new_fields
      click_on 'Salvar'
      expect(page).to have_content 'sucesso'
    end

    it 'updates profile info' do
      visit edit_user_registration_path
      fill_admin_profile_fields
      click_on 'Atualizar'
      visit edit_user_registration_path
      expect(first('#user_signature').value).to eq signature
    end
  end

  describe 'as common user' do
    before :each do
      login_as_common_user
    end

    it 'tries to add a new user' do
      visit new_user_path
      expect(page).to have_content 'Acesso negado!'
    end

    it 'tries to edit another user' do
      visit edit_user_path non_logged_user
      expect(page).to have_content 'Acesso negado!'
    end

    it 'updates profile info' do
      visit edit_user_registration_path
      fill_common_user_profile_fields
      click_on 'Atualizar'
      visit edit_user_registration_path
      expect(first('#user_signature').value).to eq signature
    end
  end


  # == Helper methods =============================================================

  def fill_new_fields
    fill_in 'Nome', with: 'Joaozinho'
    fill_in 'E-mail', with: 'joao@semdedo.com'
    fill_in 'Senha', with: 'fulano0123'
    fill_in 'Confirmação da nova senha', with: 'fulano0123'
    select('Usuário', from: 'Grupo')
  end

  def fill_admin_profile_fields
    fill_in 'Assinatura', with: signature
    fill_in 'Senha atual', with: 'fulano0123'
  end

  def fill_common_user_profile_fields
    fill_in 'Assinatura', with: signature
    fill_in 'Senha atual', with: 'usuario_comum'
  end

  def try_to_login_as_inactive_user
    fill_in 'E-mail', with: 'teste_inativo@yahoo.com.br'
    fill_in 'Senha', with: 'usuario_teste'
    check 'Manter-me logado'

    click_on 'Login'
  end
end
