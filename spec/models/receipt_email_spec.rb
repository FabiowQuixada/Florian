require "rails_helper"

describe ReceiptEmail, :type => :model do

  it { should validate_presence_of(:recipients_array).with_message I18n.t('errors.email.one_recipient') }
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:day_of_month) }
  it { should validate_presence_of(:company) }
  it { should validate_presence_of(:body) }

  # Relationships
  it { should belong_to :company }
  it { should have_many :email_histories }

end