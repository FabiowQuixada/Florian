require 'rails_helper'

describe SystemSetting, type: :request do
  before :each do
    login_as_admin
    visit edit_system_setting_path described_class.first
    page.find('#tab_1_title').click
  end

  include_examples 'an e-mail address table', %w(pse_recipients_array pse_private_recipients_array)
end
