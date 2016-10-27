require 'rails_helper'

describe EmailHistory, type: :model do
  it { is_expected.to define_enum_for(:send_type) }

  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_presence_of(:recipients_array) }
  it { is_expected.to validate_presence_of(:body) }


  # Relationships
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :receipt_email }

  # Methods #################################################################################
  describe '#send_type_desc' do
    it { expect((build :email_history, :auto).send_type_desc).to eq I18n.t('enums.email_history.send_type.auto') }
    it { expect((build :email_history, :resend).send_type_desc).to eq I18n.t('enums.email_history.send_type.resend') }
    it { expect((build :email_history, :test).send_type_desc).to eq I18n.t('enums.email_history.send_type.test') }
  end

  describe '.recent_emails' do
  end
end
