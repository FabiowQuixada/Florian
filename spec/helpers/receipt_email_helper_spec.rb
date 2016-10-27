require 'rails_helper'

describe ReceiptEmailHelper do
  it { expect(helper.resend_btn).to eq "<a class=\"resend_btn\" href=\"javascript:void(0)\"><img title=\"#{I18n.t('description.email.resend')}\" alt=\"#{I18n.t('description.email.resend')}\" src=\"/assets/send_email-3f5093d5183a64d1f963e8b256ce7db0411140658cb3efd6298a08b5d1f8b736.png\" /></a>" }
  # it {expect(helper.send_test_btn).to eq 'be_nil'}
  it { expect(helper.recent_emails_btn).to eq "<a id=\"recent_emails_btn\" class=\"btn btn-primary\" href=\"javascript:void(0)\">#{I18n.t('helpers.receipt_email.recent')}</a>" }

  describe'#resend_form_btn' do
    let(:new_model) { build :receipt_email }
    let(:persisted_model) { ReceiptEmail.first }

    it { expect(helper.resend_form_btn(new_model)).to be_nil }
    it { expect(helper.resend_form_btn(persisted_model)).to eq "<a class=\"btn btn-primary resend_btn\" href=\"javascript:void(0)\">#{I18n.t('helpers.action.email.resend')}</a>" }
  end

  describe'#send_test_form_btn' do
    let(:new_model) { build :receipt_email }
    let(:persisted_model) { ReceiptEmail.first }

    it { expect(helper.send_test_form_btn(new_model)).to be_nil }
    it { expect(helper.send_test_form_btn(persisted_model)).to eq "<a class=\"btn btn-primary send_test_btn\" href=\"javascript:void(0)\">#{I18n.t('helpers.action.email.send_test')}</a>" }
  end
end
