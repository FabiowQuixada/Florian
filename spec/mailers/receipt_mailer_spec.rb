require 'rails_helper'

describe ReceiptMailer, type: :mailer do
  let(:receipt) { create :receipt_email }
  let(:user) { User.first }

  describe 'autosend' do
    let(:competence) { Date.today }
    let(:mail) { described_class.send_automatic_receipt_email(receipt).deliver_now }

    it_behaves_like 'an receipt e-mail'
    it { expect(mail.to).to eq(SAMPLE_RECIPIENTS.split(/,/)) }
    it { expect(mail.subject).to eq(receipt.processed_title(user, competence)) }
    it { expect(body_text(mail)).to eq(receipt.processed_body(user, Date.today)) }
  end

  describe 'test' do
    context 'with present competence' do
      let(:competence) { Date.today }
      let(:mail) { described_class.send_test_receipt_email(receipt, user, competence).deliver_now }

      it_behaves_like 'an receipt e-mail'
      it { expect(mail.to).to eq([user.email]) }
      it { expect(mail.subject).to eq(I18n.t('helpers.test_email_prefix') + receipt.processed_title(user, competence)) }
      it { expect(body_text(mail)).to eq(receipt.processed_body(user, competence)) }
    end

    context 'with future competence' do
      let(:competence) { Date.today.to_time.advance(months: 6).to_date }
      let(:mail) { described_class.send_test_receipt_email(receipt, user, competence).deliver_now }

      it_behaves_like 'an receipt e-mail'
      it { expect(mail.to).to eq([user.email]) }
      it { expect(mail.subject).to include(I18n.localize(competence, format: :competence).capitalize) }
      it { expect(body_text(mail)).to include(I18n.localize(competence, format: :competence).capitalize) }
    end
  end

  describe 'resend' do
    context 'with present competence' do
      let(:competence) { Date.today }
      let(:mail) { described_class.resend_receipt_email(receipt, competence, user).deliver_now }

      it_behaves_like 'an receipt e-mail'
      it { expect(mail.to).to eq(SAMPLE_RECIPIENTS.split(/,/)) }
      it { expect(mail.subject).to eq(receipt.processed_title(user, competence)) }
      it { expect(body_text(mail)).to eq(receipt.processed_body(user, competence)) }
    end

    context 'with future competence' do
      let(:competence) { Date.today.to_time.advance(months: 6).to_date }
      let(:mail) { described_class.resend_receipt_email(receipt, competence, user).deliver_now }

      it_behaves_like 'an receipt e-mail'
      it { expect(mail.to).to eq(SAMPLE_RECIPIENTS.split(/,/)) }
      it { expect(body_text(mail)).to include(I18n.localize(competence, format: :competence).capitalize) }
    end
  end
end
