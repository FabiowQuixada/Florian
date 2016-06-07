require 'rails_helper'

describe SystemSetting, type: :model do
  it { should validate_presence_of(:pse_recipients_array).with_message I18n.t('errors.system_setting.recipients') }
  it { should validate_presence_of(:pse_private_recipients_array).with_message I18n.t('errors.system_setting.private_recipients') }
  it { should validate_presence_of(:re_title) }
  it { should validate_presence_of(:re_body) }
  it { should validate_presence_of(:pse_title) }
  it { should validate_presence_of(:pse_body) }
  it { should validate_presence_of(:pse_day_of_month) }


  # Relationships
  it { should belong_to :user }
end
