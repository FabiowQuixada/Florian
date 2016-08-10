module ValidUserRequestHelper
  def login_as_common_user

    visit root_path

    email = 'teste_comum@yahoo.com.br'

    fill_in 'E-mail', with: email
    fill_in 'Senha', with: 'usuario_comum'

    @logged_user = User.where(email: email).first

    click_on 'Login'
  end

  def login_as_admin
    visit root_path

    email = SYSTEM_EMAIL

    fill_in 'E-mail', with: email
    fill_in 'Senha', with: 'fulano0123'

    @logged_user = User.where(email: email).first

    click_on 'Login'
  end

  def logged_user
    @logged_user
  end

  def non_logged_user
    User.where('email != ?', @logged_user.email).first
  end
end

RSpec.configure do |config|
  config.include ValidUserRequestHelper, type: :request
end
