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
    let(:expected_title) { processed_title(receipt, date) }
    let(:expected_body) { processed_body(receipt, date, user) }
    let(:expected_receipt_text) { processed_receipt_text(receipt, date) }

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
    it { expect(receipt.send(:apply_value_tag_to, receipt.send(:receipt_text))).to include LocaleHandler.full_money_desc(receipt.value) }

    it { expect(processed_receipt_text(receipt)).to include receipt.competence(Date.today).capitalize }
    it { expect(processed_receipt_text(receipt)).to include receipt.maintainer.registration_name }
    it { expect(processed_receipt_text(receipt)).to include LocaleHandler.full_money_desc(receipt.value) }
  end

  def processed_title(receipt, date)
    I18n.t('defaults.report.receipt.email_title')
        .sub(I18n.t('tags.competence'), I18n.localize(date, format: :competence).capitalize)
        .sub(I18n.t('tags.maintainer'), receipt.maintainer.name)
  end

  def processed_body(receipt, date, user)
    I18n.t('defaults.report.receipt.email_body')
        .sub(I18n.t('tags.competence'), I18n.localize(date, format: :competence).capitalize)
        .sub(I18n.t('tags.value'), LocaleHandler.full_money_desc(receipt.value))
        .sub(I18n.t('tags.maintainer'), receipt.maintainer.name) + user.full_signature
  end

  def processed_receipt_text(receipt, date = Date.today)
    receipt.send(:apply_all_tags_to, receipt.send(:receipt_text), date)
  end
end
