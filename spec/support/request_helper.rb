module RequestHelper

  def go_back
    page.find('#form_back_btn').click
    wait
  end

  def wait
    sleep 0.5
  end

  def click_on_save_btn
    click_on I18n.t('helpers.action.save')
  end

  def click_on_update_btn
    click_on I18n.t('helpers.action.update')
  end

  def input_blur
    page.find('body').click
  end

  def expect_success_msg
    expect(page).to have_content 'sucesso' if I18n.locale == :"pt-BR"
    expect(page).to have_content 'success' if I18n.locale == :en
  end

  def expect_access_denied_msg
    expect(page).to have_content I18n.t('alert.access_denied')
  end

  def i18n_field(att)
    I18n.t "activerecord.attributes.#{described_class.name.underscore}.#{att}"
  end
end

RSpec.configure do |config|
  config.include RequestHelper, type: :request
end
