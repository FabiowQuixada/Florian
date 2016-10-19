require 'rails_helper'

describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:role) }
  it { is_expected.to validate_presence_of(:signature) }

  it { expect(build(:user, :admin).admin?).to be true }
  it { expect(build(:user, :guest).guest?).to be true }
  it { expect(build(:user, active: false).active_for_authentication?).to be false }
  it { expect(build(:user).active_for_authentication?).to be true }

  it { expect(build(:user, :guest).admin?).to be false }

  it { is_expected.to validate_uniqueness_of(:name) }

  # Relationships
  it { is_expected.to belong_to :role }
  it { is_expected.to have_one :system_setting }

  # Methods #################################################################################

  describe '#admin?' do
    let(:admin) { build :user, :admin }
    let(:common) { build :user }
    let(:guest) { build :user, :guest }

    it { expect(admin.admin?).to be true }
    it { expect(common.admin?).to be false }
    it { expect(guest.admin?).to be false }
  end

  describe '#guest?' do
    let(:admin) { build :user, :admin }
    let(:common) { build :user }
    let(:guest) { build :user, :guest }

    it { expect(admin.guest?).to be false }
    it { expect(common.guest?).to be false }
    it { expect(guest.guest?).to be true }
  end

  describe '#default_values' do
    let(:user) { described_class.new }
    it { expect(user.bcc).to eq user.email }
    it { expect(user.signature).to eq user.name }
  end

  describe '#build_default_system_setting' do
    let(:system_setting) { (build :user).system_setting }

    it { expect(system_setting.pse_recipients_array).to eq SAMPLE_RECIPIENTS }
    it { expect(system_setting.pse_title).to eq I18n.t('defaults.report.product_and_service.email_title') }
    it { expect(system_setting.pse_body).to eq I18n.t('defaults.report.product_and_service.monthly_email_body') }
    it { expect(system_setting.re_title).to eq I18n.t('defaults.report.receipt.email_title') }
    it { expect(system_setting.re_body).to eq I18n.t('defaults.report.receipt.email_body') }
  end

  describe '#active=' do
    it 'activates a user' do
      user = build :user
      user.active = true
      expect(user.active?).to be true
    end

    it 'deactivates a user' do
      user = build :user
      user.active = false
      expect(user.active?).to be false
    end

    it 'cannot deactivate an admin' do
      expect { (build :user, :admin).active = false }.to raise_exception I18n.t('errors.user.cannot_deactivate_admin')
    end
  end
end
