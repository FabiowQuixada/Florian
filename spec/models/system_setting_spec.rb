require 'rails_helper'

describe SystemSetting, type: :model do
  it { is_expected.to validate_presence_of(:pse_recipients_array).with_message I18n.t('errors.system_setting.recipients') }
  it { is_expected.to validate_presence_of(:pse_private_recipients_array).with_message I18n.t('errors.system_setting.private_recipients') }
  it { is_expected.to validate_presence_of(:re_title) }
  it { is_expected.to validate_presence_of(:re_body) }
  it { is_expected.to validate_presence_of(:pse_title) }
  it { is_expected.to validate_presence_of(:pse_body) }

  it { expect(build(:system_setting, pse_private_recipients_array: nil).private_recipients_as_array).to eq [] }

  describe 'processed texts' do
    let(:user) { build :user }
    let(:setting) { build :system_setting }
    let(:current_competence) { I18n.localize(Date.today, format: :competence) }
    let(:current_expected_title) { I18n.t('defaults.report.product_and_service.email_title').sub(I18n.t('tags.competence'), current_competence.capitalize) }
    let(:current_expected_body) { processed_body(current_competence) }
    let(:past_date) { Date.today - 6.months }
    let(:past_competence) { I18n.localize(past_date, format: :competence) }
    let(:past_expected_title) { I18n.t('defaults.report.product_and_service.email_title').sub(I18n.t('tags.competence'), past_competence.capitalize) }
    let(:past_expected_body) { I18n.t('defaults.report.product_and_service.monthly_email_body').sub(I18n.t('tags.competence'), past_competence.capitalize) }

    it { expect(setting.pse_processed_title).to eq current_expected_title }
    it { expect(setting.pse_processed_body(user)).to include current_expected_body }
    it { expect(setting.pse_processed_body(user)).to end_with user.full_signature }
    it { expect(setting.pse_processed_title(past_date)).to eq past_expected_title }
    it { expect(setting.pse_processed_body(user, past_date)).to include past_expected_body }
    it { expect(setting.pse_processed_body(user, past_date)).to end_with user.full_signature }
  end

  describe 'tags' do
    let(:date) { Date.yesterday }
    let(:setting) { build :system_setting }

    it { expect(setting.send(:apply_competence_tag_to, setting.send(:pse_title))).to include setting.competence(Date.today).capitalize }
    it { expect(setting.send(:apply_competence_tag_to, setting.send(:pse_body))).to include setting.competence(Date.today).capitalize }
    it { expect(setting.send(:apply_competence_tag_to, setting.send(:pse_title), date)).to include setting.competence(date).capitalize }
    it { expect(setting.send(:apply_competence_tag_to, setting.send(:pse_body), date)).to include setting.competence(date).capitalize }

    it { expect(apply_all_tags_to(setting, 'title')).to include setting.competence(Date.today).capitalize }
    it { expect(apply_all_tags_to(setting, 'body')).to include setting.competence(Date.today).capitalize }
    it { expect(apply_all_tags_to(setting, 'title', date)).to include setting.competence(date).capitalize }
    it { expect(apply_all_tags_to(setting, 'body', date)).to include setting.competence(date).capitalize }
  end


  # Methods #################################################################################
  describe '#recipients_as_array' do
    let(:setting) { build :system_setting }
    let(:recipientless_setting) { build :system_setting, pse_recipients_array: nil }

    it { expect(setting.recipients_as_array).to eq SAMPLE_RECIPIENTS.split(/,/) }
    it { expect(recipientless_setting.recipients_as_array).to eq [] }
  end

  describe '#private_recipients_as_array' do
    let(:setting) { build :system_setting }
    let(:private_recipientless_setting) { build :system_setting, pse_private_recipients_array: nil }

    it { expect(setting.private_recipients_as_array).to eq SAMPLE_RECIPIENTS.split(/,/) }
    it { expect(private_recipientless_setting.private_recipients_as_array).to eq [] }
  end

  # Helper methods ########################################

  def apply_all_tags_to(setting, field, date = Date.today)
    setting.send(:apply_all_tags_to, setting.send("pse_#{field}"), date)
  end

  def processed_body(competence)
    I18n.t('defaults.report.product_and_service.monthly_email_body').sub(I18n.t('tags.competence'), competence.capitalize)
  end
end
