require 'test_helper'

class ReceiptEmailFlowTest < Capybara::Rails::TestCase

  test 'resend e-mail through listing page' do
    login_as_admin

    visit receipt_emails_path

    all('.resend_btn').first.click
    fill_in 'resend_competence', with: '10/2015' + "\n"
    click_on 'Enviar'

    assert_content page, 'sucesso'
  end

  test 'resend e-mail through update page' do
    login_as_admin

    visit edit_receipt_email_path ReceiptEmail.first.id

    all('.resend_btn').first.click
    fill_in 'resend_competence', with: '10/2015' + "\n"
    click_on 'Enviar'

    assert_content page, 'sucesso'
  end

  test 'send test e-mail through listing page' do
    login_as_admin

    visit receipt_emails_path

    all('.send_test_btn').first.click
    fill_in 'send_test_competence', with: '10/2015' + "\n"
    click_on 'Enviar'

    assert_content page, 'sucesso'
  end

  test 'send test e-mail through update page' do
    login_as_admin

    visit edit_receipt_email_path ReceiptEmail.first.id

    all('.send_test_btn').first.click
    fill_in 'send_test_competence', with: '10/2015' + "\n"
    click_on 'Enviar'

    assert_content page, 'sucesso'
  end
end
