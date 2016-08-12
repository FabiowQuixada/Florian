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
end
