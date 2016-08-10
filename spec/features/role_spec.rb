require 'rails_helper'

describe Role, type: :request do
  describe 'as admin' do
    before :each do
      login_as_admin
    end

    it 'adds a new role' do
      visit new_role_path
      fill_form
      click_on 'Salvar'
      expect(page).to have_content 'sucesso'
    end

    it 'updates role' do
      visit edit_role_path described_class.first
      fill_in 'Descrição', with: 'lala'
      click_on 'Atualizar'
      visit edit_role_path described_class.first
      expect(first('#role_description').value).to eq 'lala'
    end
  end

  describe 'as common user' do
    before :each do
      login_as_common_user
    end

    it 'tries to add a new role' do
      visit new_role_path
      expect(page).to have_content 'Acesso negado!'
    end

    it 'updates role' do
      visit edit_role_path described_class.first
      expect(page).to have_content 'Acesso negado!'
    end
  end


  # == Helper methods =============================================================

  def fill_form
    fill_in 'Nome', with: 'Grupo'
    fill_in 'Descrição', with: 'desc'
  end
end
