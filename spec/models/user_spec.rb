require 'rails_helper'

describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:role) }
  # it { should validate_presence_of(:signature) }
  it { should validate_presence_of(:bcc) }

  it { expect(build(:user, :admin).admin?).to be true }
  it { expect(build(:user, :guest).guest?).to be true }
  it { expect(build(:user, active: false).active_for_authentication?).to be false }
  it { expect(build(:user).active_for_authentication?).to be true }

  it { expect(build(:user, :guest).admin?).to be false }

  # it { should validate_uniqueness_of(:name) }

  # Relationships
  it { should belong_to :role }
  it { should have_one :system_setting }
end
