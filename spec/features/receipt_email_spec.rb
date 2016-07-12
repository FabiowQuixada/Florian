require 'rails_helper'

describe ReceiptEmail, type: :request do
  context 'in listing page' do
    before :each do
      login_as_admin
      visit receipt_emails_path
    end

    it 'resends e-mail' do
      all('.resend_btn').first.click
      fill_in 'resend_competence', with: '10/2015' + "\n"
      click_on 'Enviar'
    end

    it 'sends test e-mail' do
      all('.send_test_btn').first.click
      fill_in 'send_test_competence', with: '10/2015' + "\n"
      click_on 'Enviar'
    end

    after :each do
      expect(page).to have_content'sucesso'
    end
  end

  context 'in update page' do
    before :each do
      login_as_admin
      visit edit_receipt_email_path described_class.first.id
    end

    it 'resends e-mail' do
      all('.resend_btn').first.click
      fill_in 'resend_competence', with: '10/2015' + "\n"
      click_on 'Enviar'
    end

    it 'sends test e-mail' do
      all('.send_test_btn').first.click
      fill_in 'send_test_competence', with: '10/2015' + "\n"
      click_on 'Enviar'
    end

    after :each do
      expect(page).to have_content'sucesso'
    end
  end
end
