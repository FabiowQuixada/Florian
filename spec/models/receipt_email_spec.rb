require 'rails_helper'

describe ReceiptEmail, type: :model do
  it { is_expected.to validate_presence_of(:recipients_array).with_message I18n.t('errors.email.one_recipient') }
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_presence_of(:day_of_month) }
  it { is_expected.to validate_presence_of(:maintainer) }
  it { is_expected.to validate_presence_of(:body) }

  # Relationships
  it { is_expected.to belong_to :maintainer }
  it { is_expected.to have_many :email_histories }

  it { expect(build(:receipt_email, day_of_month: Date.today.day).competence).to eq I18n.localize(Date.today, format: :competence) }

  it 'saves its competence as day 1 of the month' do
    receipt = described_class.create
    expect(receipt.day_of_month).to eq 1
  end

  it { expect(described_class::DAILY_SEND_HOUR).to eq 7 }
  it { expect(described_class::RECENT_EMAILS_DAYS).to eq 7 }

  describe 'processed texts' do
    let(:user) { User.first }
    let(:date) { Date.today + 1.month }
    let(:receipt) { described_class.first }
    let(:expected_title) { "Recibo de Doação IAQ Maintainer 7 Ltda. - " + I18n.localize(date, format: :competence).capitalize }
    let(:expected_body) { "Prezados, segue em anexo o recibo de doação da Maintainer 7 Ltda., no valor de R$ 3,00 (três reais) referente a " + I18n.localize(date, format: :competence).capitalize + '.' + user.full_signature }
    let(:expected_receipt_text) { "A ONG – Instituto de Apoio ao Queimado (IAQ), inscrita sob o CNPJ/MF nº 08.093.224/0001-05, situada à Rua Visconde de Sabóia, nº 75, salas 01 a 16 – Centro, recebeu da Maintainer 7, inscrito sob o CNPJ/MF nº " + receipt.maintainer.cnpj.to_s + ", situada na Rua X, a importância supra de R$ 3,00 (três reais) como doação em " + I18n.localize(date, format: :competence).capitalize + '.' }

    it { expect(receipt.processed_title(user, date)).to eq expected_title }
    it { expect(receipt.processed_body(user, date)).to eq expected_body }
    it { expect(receipt.processed_receipt_text(date)).to eq expected_receipt_text }
  end

  # Private methods
  it 'returns `person` maintainer text when its maintainer is so' do
    receipt = create(:receipt_email, :person_maintainer)
    expect(receipt.send(:receipt_text)).to eq receipt.send(:person_text)
  end

  it 'returns `company` maintainer text when its maintainer is so' do
    receipt = build(:receipt_email, :company_maintainer)
    expect(receipt.send(:receipt_text)).to eq receipt.send(:company_text)
  end

  describe 'tags' do
    let(:receipt) { build(:receipt_email, :company_maintainer) }
    let(:date) { Date.new(2007, 5, 12) }

    it { expect(receipt.send(:apply_competence_tag_to, receipt.send(:receipt_text), date)).to include receipt.competence(date).capitalize }
    it { expect(receipt.send(:apply_maintainer_tag_to, receipt.send(:receipt_text))).to include receipt.maintainer.registration_name }
    it { expect(receipt.send(:apply_value_tag_to, receipt.send(:receipt_text))).to include ActionController::Base.helpers.number_to_currency(receipt.value) + ' (' + receipt.value.real.por_extenso + ')' }

    it { expect(receipt.send(:apply_all_tags_to, receipt.send(:receipt_text))).to include receipt.competence(Date.today).capitalize }
    it { expect(receipt.send(:apply_all_tags_to, receipt.send(:receipt_text))).to include receipt.maintainer.registration_name }
    it { expect(receipt.send(:apply_all_tags_to, receipt.send(:receipt_text))).to include ActionController::Base.helpers.number_to_currency(receipt.value) + ' (' + receipt.value.real.por_extenso + ')' }
  end
end
