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

  it { expect(described_class::DAILY_SEND_HOUR).to eq 7 }
  it { expect(described_class::RECENT_EMAILS_DAYS).to eq 7 }

  describe 'processed texts' do
    let(:user) { User.first }
    let(:date) { Date.today + 1.month }
    let(:receipt) { described_class.first }
    let(:expected_title) { "Recibo de Doação IAQ Company 7 Ltda. - " + I18n.localize(date, format: :competence).capitalize }
    let(:expected_body) { "Prezados, segue em anexo o recibo de doação da Company 7 Ltda., no valor de R$ 3,00 (três reais) referente a " + I18n.localize(date, format: :competence).capitalize + '.' + user.signature }
    let(:expected_receipt_text) { "A ONG – Instituto de Apoio ao Queimado (IAQ), inscrita sob o CNPJ/MF nº 08.093.224/0001-05, situada à Rua Visconde de Sabóia, nº 75, salas 01 a 16 – Centro, recebeu da Company 7, inscrito sob o CNPJ/MF nº " + receipt.company.cnpj.to_s + ", situada na Rua X, a importância supra de R$ 3,00 (três reais) como doação em " + I18n.localize(date, format: :competence).capitalize + '.' }

    it { expect(receipt.processed_title(user, date)).to eq expected_title }
    it { expect(receipt.processed_body(user, date)).to eq expected_body }
    it { expect(receipt.processed_receipt_text(date)).to eq expected_receipt_text }
  end

  # Private methods
  it 'returns PF text when its company is so' do
    receipt = create(:receipt_email, :pf_company)
    expect(receipt.send(:receipt_text)).to eq receipt.send(:pf_text)
  end

  it 'returns PJ text when its company is so' do
    receipt = build(:receipt_email, :pj_company)
    expect(receipt.send(:receipt_text)).to eq receipt.send(:pj_text)
  end

  context '#competence' do
    let(:current_month) { I18n.localize(Date.today, format: :competence) }
    let(:next_month) { I18n.localize(Date.today + 1.month, format: :competence) }

    it { expect(build(:receipt_email, day_of_month: Date.yesterday.day).competence).to eq next_month }
    it { expect(build(:receipt_email, day_of_month: Date.tomorrow.day).competence).to eq current_month }
  end

  context '#validate_day_of_month' do
    let(:receipt) { build(:receipt_email) }

    it { expect(build(:receipt_email, day_of_month: nil).send(:validate_day_of_month)).to be_nil }
    it { expect(build(:receipt_email, day_of_month: 0).send(:validate_day_of_month)).to include receipt.blank_error_message('day_of_month') }
    it { expect(build(:receipt_email, day_of_month: 29).send(:validate_day_of_month)).to include I18n.t('errors.email.month_max') }
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
