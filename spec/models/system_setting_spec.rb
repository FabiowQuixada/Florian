require 'rails_helper'

describe SystemSetting, type: :model do
  it { is_expected.to validate_presence_of(:pse_recipients_array).with_message I18n.t('errors.system_setting.recipients') }
  it { is_expected.to validate_presence_of(:pse_private_recipients_array).with_message I18n.t('errors.system_setting.private_recipients') }
  it { is_expected.to validate_presence_of(:re_title) }
  it { is_expected.to validate_presence_of(:re_body) }
  it { is_expected.to validate_presence_of(:pse_title) }
  it { is_expected.to validate_presence_of(:pse_body) }
  it { is_expected.to validate_presence_of(:pse_day_of_month) }


  # Relationships
  it { is_expected.to belong_to :user }


  context 'tags' do
    let(:setting) { build(:system_setting) }
    let(:date) { Date.yesterday }

    it { expect(setting.send(:apply_competence_tag_to, setting.send(:pse_title))).to include setting.competence(Date.today).capitalize }
    it { expect(setting.send(:apply_competence_tag_to, setting.send(:pse_body))).to include setting.competence(Date.today).capitalize }
    it { expect(setting.send(:apply_competence_tag_to, setting.send(:pse_title), date)).to include setting.competence(date).capitalize }
    it { expect(setting.send(:apply_competence_tag_to, setting.send(:pse_body), date)).to include setting.competence(date).capitalize }

    it { expect(setting.send(:apply_all_tags_to, setting.send(:pse_title))).to include setting.competence(Date.today).capitalize }
    it { expect(setting.send(:apply_all_tags_to, setting.send(:pse_body))).to include setting.competence(Date.today).capitalize }
    it { expect(setting.send(:apply_all_tags_to, setting.send(:pse_title), date)).to include setting.competence(date).capitalize }
    it { expect(setting.send(:apply_all_tags_to, setting.send(:pse_body), date)).to include setting.competence(date).capitalize }
  end
end
