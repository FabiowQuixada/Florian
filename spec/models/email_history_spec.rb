require 'rails_helper'

describe EmailHistory, type: :model do
  it { is_expected.to define_enum_for(:send_type) }

  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_presence_of(:recipients_array) }
  it { is_expected.to validate_presence_of(:body) }


  # Relationships
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :receipt_email }

  # it { is_expected.to validate_inclusion_of(:send_type), in: EmailHistory.send_types.keys }
end
