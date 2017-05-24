require 'rails_helper'

describe ReceiptEmailHelper do
  it { expect(helper.resend_btn).to eq "<a class=\"resend_btn\" href=\"javascript:void(0)\"><img title=\"#{I18n.t('description.email.resend')}\" alt=\"#{I18n.t('description.email.resend')}\" src=\"/assets/send_email-3f5093d5183a64d1f963e8b256ce7db0411140658cb3efd6298a08b5d1f8b736.png\" /></a>" }
  # it {expect(helper.send_test_btn).to eq 'be_nil'}
  it { expect(helper.recent_emails_btn).to eq "<a id=\"recent_emails_btn\" class=\"btn btn-primary\" href=\"javascript:void(0)\">#{I18n.t('helpers.receipt_email.recent')}</a>" }

  describe '#resend_form_btn' do
    let(:new_model) { build :receipt_email }
    let(:persisted_model) { ReceiptEmail.first }

    it { expect(helper.resend_form_btn(new_model)).to be_nil }
    it { expect(helper.resend_form_btn(persisted_model)).to eq "<a class=\"btn btn-primary resend_btn\" href=\"javascript:void(0)\">#{I18n.t('helpers.action.email.resend')}</a>" }
  end

  describe '#send_test_form_btn' do
    let(:new_model) { build :receipt_email }
    let(:persisted_model) { ReceiptEmail.first }

    it { expect(helper.send_test_form_btn(new_model)).to be_nil }
    it { expect(helper.send_test_form_btn(persisted_model)).to eq "<a class=\"btn btn-primary send_test_btn\" href=\"javascript:void(0)\">#{I18n.t('helpers.action.email.send_test')}</a>" }
  end

  # There's probably a better way to test this
  describe '#receipt_maintainer_select' do
    it 'displays a `maintainer`-group list if the object is not persisted' do
      form_for ReceiptEmail.new do |f|
        expect(helper.receipt_maintainer_select(f)).to include 'Maintainer in the `maintainer` group'
        expect(helper.receipt_maintainer_select(f)).not_to include 'Maintainer in the `punctual` group'
      end
    end

    it 'displays only the object`s name if it is persisted' do
      obj = ReceiptEmail.first
      form_for obj do |f|
        expect(helper.receipt_maintainer_select(f)).to include obj.maintainer.name
        expect(helper.receipt_maintainer_select(f).scan('<option').size).to eq 1
      end
    end
  end
end
