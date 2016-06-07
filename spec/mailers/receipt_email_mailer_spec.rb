require 'rails_helper'

describe ReceiptEmail, type: :mailer do
  describe 'Receipt Autosend' do
    let(:receipt) { create :receipt_email }
    let(:user) { User.first }
    let(:mail) { FlorianMailer.send_automatic_receipt_email(receipt).deliver_now }

    it 'renders the receiver email' do
      expect(mail.to).to eq(SAMPLE_RECIPIENTS.split(/,/))
    end

    it 'renders the sender email' do
      expect(mail.from).to eq([user.email])
    end

    it 'renders the e-mail title' do
      expect(mail.subject).to eq(receipt.processed_title(user, Date.today))
    end

    it 'renders the e-mail body' do
      # expect(mail.body.encoded).to eq(receipt.processed_body(user, Date.today))
    end

    it 'renders the users signature' do
      # expect(mail.body.encoded).to include(user.signature)
    end

    it 'renders mails attachment' do
      expect(mail.attachments).to have(1).attachment
      attachment = mail.attachments[0]
      expect(attachment).to be_a_kind_of(Mail::Part)
      expect(attachment.content_type).to be_start_with('application/pdf;')
      expect(attachment.filename).to eq('recibo_de_doacao.pdf')
    end
  end

  describe 'Receipt Test (Current Month)' do
    let(:current_month) { Date.today }
    let(:user) { create :user, :common }
    let(:receipt) { create :receipt_email }
    let(:mail) { FlorianMailer.send_test_receipt_email(receipt, current_month, user).deliver_now }

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq([SYSTEM_EMAIL])
    end

    it 'renders the e-mail title' do
      expect(mail.subject).to eq(I18n.t('helpers.test_email_prefix') + receipt.processed_title(user, current_month))
    end

    it 'renders the e-mail body' do
      # expect(mail.body.encoded).to eq(receipt.processed_body(user, current_month))
    end

    it 'renders mails attachment' do
      expect(mail.attachments).to have(1).attachment
      attachment = mail.attachments[0]
      expect(attachment).to be_a_kind_of(Mail::Part)
      expect(attachment.content_type).to be_start_with('application/pdf;')
      expect(attachment.filename).to eq('recibo_de_doacao.pdf')
    end
  end

  describe 'Receipt Test (Future)' do
    let(:future_month) { Date.today.to_time.advance(months: 6).to_date }
    let(:user) { build :user, :common }
    let(:receipt) { create :receipt_email }
    let(:mail) { FlorianMailer.send_test_receipt_email(receipt, future_month, user).deliver_now }

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq([SYSTEM_EMAIL])
    end

    it 'renders the e-mail title (future)' do
      expect(mail.subject).to include(I18n.localize(future_month, format: :competence).capitalize)
    end

    it 'renders the e-mail body (future)' do
      # expect(mail.body.encoded).to include(I18n.localize(future_month, format: :competence).capitalize)
    end

    it 'renders mails attachment' do
      expect(mail.attachments).to have(1).attachment
      attachment = mail.attachments[0]
      expect(attachment).to be_a_kind_of(Mail::Part)
      expect(attachment.content_type).to be_start_with('application/pdf;')
      expect(attachment.filename).to eq('recibo_de_doacao.pdf')
    end
  end

  describe 'Receipt Resend (Current Month)' do
    let(:current_month) { Date.today }
    let(:user) { build :user, :common }
    let(:receipt) { create :receipt_email }
    let(:mail) { FlorianMailer.resend_receipt_email(receipt, current_month, user).deliver_now }

    it 'renders the receiver email' do
      expect(mail.to).to eq(SAMPLE_RECIPIENTS.split(/,/))
    end

    it 'renders the sender email' do
      expect(mail.from).to eq([SYSTEM_EMAIL])
    end

    it 'renders the e-mail title' do
      expect(mail.subject).to eq(receipt.processed_title(user, current_month))
    end

    it 'renders the e-mail body' do
      # expect(mail.body.encoded).to eq(receipt.processed_body(user, current_month))
    end

    it 'renders mails attachment' do
      expect(mail.attachments).to have(1).attachment
      attachment = mail.attachments[0]
      expect(attachment).to be_a_kind_of(Mail::Part)
      expect(attachment.content_type).to be_start_with('application/pdf;')
      expect(attachment.filename).to eq('recibo_de_doacao.pdf')
    end
  end

  describe 'Receipt Resend (Future)' do
    let(:future_month) { Date.today.to_time.advance(months: 6).to_date }
    let(:user) { build :user, :common }
    let(:receipt) { create :receipt_email }
    let(:mail) { FlorianMailer.resend_receipt_email(receipt, future_month, user).deliver_now }

    it 'renders the receiver email' do
      expect(mail.to).to eq(SAMPLE_RECIPIENTS.split(/,/))
    end

    it 'renders the sender email' do
      expect(mail.from).to eq([SYSTEM_EMAIL])
    end

    it 'renders the e-mail title (future)' do
      expect(mail.subject).to include(I18n.localize(future_month, format: :competence).capitalize)
    end

    it 'renders the e-mail body (future)' do
      # expect(mail.body.encoded).to include(I18n.localize(future_month, format: :competence).capitalize)
    end

    it 'renders mails attachment' do
      expect(mail.attachments).to have(1).attachment
      attachment = mail.attachments[0]
      expect(attachment).to be_a_kind_of(Mail::Part)
      expect(attachment.content_type).to be_start_with('application/pdf;')
      expect(attachment.filename).to eq('recibo_de_doacao.pdf')
    end
  end
end
