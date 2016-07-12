require 'rails_helper'

describe User, type: :request do
  it 'inactive user should not login' do
    visit root_path

    try_to_login_as_inactive_user

    expect(page).to have_content 'inativada'
  end

  # == Helper methods =============================================================

  def try_to_login_as_inactive_user
    fill_in 'E-mail', with: 'teste_inativo@yahoo.com.br'
    fill_in 'Senha', with: 'usuario_teste'
    check 'Manter-me logado'

    click_on 'Login'
  end
end
