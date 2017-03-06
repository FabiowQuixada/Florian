require 'rails_helper'

describe ReceiptEmail, js: true, type: :request do
  let(:competence) { "10/2015\n" }

  context 'e-mails' do
    before :each do
      login_as_admin
      visit edit_receipt_email_path described_class.first.id
    end

    include_examples 'an e-mail address table', ['recipients_array']
  end

  context 'index' do
    before :each do
      login_as_admin
      visit receipt_emails_path
    end

    describe 'filters' do
      before :each do
        click_on I18n.t 'helpers.filters'
      end

      it 'filters by maintainer' do
        name = Maintainer.first.name
        select name, from: 'q_maintainer_id_eq'
        click_on I18n.t 'helpers.action.apply'

        find_all('#index_table td.receipt_maintainer').each { |m| expect(m.text).to eq name }
      end
    end

    it 'resends e-mail' do
      all('.resend_btn').first.click
      fill_in 'resend_competence', with: competence
      click_on_send_btn
      expect_success_msg
    end

    it 'sends test e-mail' do
      all('.send_test_btn').first.click
      fill_in 'send_test_competence', with: competence
      click_on_send_btn
      expect_success_msg
    end
  end


  context 'form' do
    before :each do
      login_as_admin
      visit edit_receipt_email_path described_class.first.id
    end

    it 'resends e-mail' do
      all('.resend_btn').first.click
      fill_in 'resend_competence', with: competence
      click_on_send_btn
    end

    it 'sends test e-mail' do
      all('.send_test_btn').first.click
      fill_in 'send_test_competence', with: competence
      click_on_send_btn
    end

    after :each do
      expect_success_msg
    end
  end

  def click_on_send_btn
    click_on I18n.t('helpers.action.email.send')
  end
end
