require 'rails_helper'

describe ReceiptEmail, type: :model do
  it { is_expected.to validate_presence_of(:recipients_array).with_message I18n.t('errors.email.one_recipient') }
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_presence_of(:day_of_month) }
  it { is_expected.to validate_presence_of(:company) }
  it { is_expected.to validate_presence_of(:body) }

  # Relationships
  it { is_expected.to belong_to :company }
  it { is_expected.to have_many :email_histories }

  # Private methods
  it 'returns PF text when its company is so' do
    receipt = create(:receipt_email, :pf_company)
    expect(receipt.send(:receipt_text)).to eq receipt.send(:pf_text)
  end

  it 'returns PJ text when its company is so' do
    receipt = build(:receipt_email, :pj_company)
    expect(receipt.send(:receipt_text)).to eq receipt.send(:pj_text)
  end

  describe 'tags' do
    let(:receipt) { build(:receipt_email, :pj_company) }
    let(:date) { Date.new(2007, 5, 12) }

    it { expect(receipt.send(:apply_competence_tag_to, receipt.send(:receipt_text), date)).to include receipt.competence(date).capitalize }
    it { expect(receipt.send(:apply_company_tag_to, receipt.send(:receipt_text))).to include receipt.company.registration_name }
    it { expect(receipt.send(:apply_value_tag_to, receipt.send(:receipt_text))).to include ActionController::Base.helpers.number_to_currency(receipt.value) + ' (' + receipt.value.real.por_extenso + ')' }

    it { expect(receipt.send(:apply_all_tags_to, receipt.send(:receipt_text))).to include receipt.competence(Date.today).capitalize }
    it { expect(receipt.send(:apply_all_tags_to, receipt.send(:receipt_text))).to include receipt.company.registration_name }
    it { expect(receipt.send(:apply_all_tags_to, receipt.send(:receipt_text))).to include ActionController::Base.helpers.number_to_currency(receipt.value) + ' (' + receipt.value.real.por_extenso + ')' }
  end
end
