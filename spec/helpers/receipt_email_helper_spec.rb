require 'rails_helper'

describe ReceiptEmailHelper do
  it { expect(helper.resend_btn).to eq '<a class="resend_btn" href="javascript:void(0)"><img title="Reenviar e-mail para mantenedoras" src="/assets/send_email-3f5093d5183a64d1f963e8b256ce7db0411140658cb3efd6298a08b5d1f8b736.png" alt="Send email" /></a>' }
  # it {expect(helper.send_test_btn).to eq 'be_nil'}
  it { expect(helper.recent_emails_btn).to eq '<a id="recent_emails_btn" class="btn btn-primary" href="javascript:void(0)">Recentes</a>' }

  describe'#resend_form_btn' do
    let(:new_model) { build :receipt_email }
    let(:persisted_model) { ReceiptEmail.first }

    it { expect(helper.resend_form_btn(new_model)).to be_nil }
    it { expect(helper.resend_form_btn(persisted_model)).to eq '<a class="btn btn-primary resend_btn" href="javascript:void(0)">Reenviar</a>' }
  end

  describe'#send_test_form_btn' do
    let(:new_model) { build :receipt_email }
    let(:persisted_model) { ReceiptEmail.first }

    it { expect(helper.send_test_form_btn(new_model)).to be_nil }
    it { expect(helper.send_test_form_btn(persisted_model)).to eq '<a class="btn btn-primary send_test_btn" href="javascript:void(0)">Enviar teste</a>' }
  end
end
