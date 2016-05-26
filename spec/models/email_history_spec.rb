require "rails_helper"

describe EmailHistory, :type => :model do

  it { should define_enum_for(:send_type) }

  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:recipients_array) }
  it { should validate_presence_of(:body) }


  # Relationships
  it { should belong_to :user }
  it { should belong_to :receipt_email }

  #it { should validate_inclusion_of(:send_type), in: EmailHistory.send_types.keys }


end