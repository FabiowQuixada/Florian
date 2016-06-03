require "rails_helper"

describe User, :type => :model do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:role) }
  it { should validate_presence_of(:signature) }
  it { should validate_presence_of(:bcc) }

  # it { should validate_uniqueness_of(:name) }

  # Relationships
  it { should belong_to :role }
  it { should have_one :system_setting }

end