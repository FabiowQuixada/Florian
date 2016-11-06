module ValidUserRequestHelper

  def login_as_common_user
    visit root_path
    user_mail = 'teste_comum@yahoo.com.br'

    fill_login_fields_with user_mail, 'usuario_comum'

    @logged_user = User.where(email: user_mail).first
    click_on_login_btn
  end

  def login_as_admin
    visit root_path
    user_mail = SYSTEM_EMAIL

    fill_login_fields_with user_mail, 'fulano0123'

    @logged_user = User.where(email: user_mail).first
    click_on_login_btn
  end

  def fill_login_fields_with(user, password)
    email_field = I18n.t('activerecord.attributes.user.email')
    password_field = I18n.t('activerecord.attributes.user.password')

    fill_in email_field, with: user
    fill_in password_field, with: password
  end

  def logged_user
    @logged_user
  end

  def non_logged_user
    User.where('email != ?', @logged_user.email).first
  end

  def click_on_login_btn
    click_on 'Login'
  end
end

RSpec.configure do |config|
  config.include ValidUserRequestHelper, type: :request
end
