module ValidUserRequestHelper
  def login_as_common_user

    visit root_path

    fill_in 'E-mail', with: 'teste_comum@yahoo.com.br'
    fill_in 'Senha', with: 'usuario_comum'
    check 'Manter-me logado'

    click_on 'Login'
  end

  def login_as_admin
    visit root_path

    fill_in 'E-mail', with: SYSTEM_EMAIL
    fill_in 'Senha', with: 'fulano0123'
    check 'Manter-me logado'

    click_on 'Login'
  end
end

RSpec.configure do |config|
  config.include ValidUserRequestHelper, type: :request
end
