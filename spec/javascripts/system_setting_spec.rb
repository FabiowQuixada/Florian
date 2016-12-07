require 'rails_helper'

describe SystemSetting, js: true, type: :request do
  before :each do
    login_as_admin
    visit system_settings_path
    page.find('#main_tab_2_title').click
  end

  include_examples 'an e-mail address table', %w(pse_recipients_array pse_private_recipients_array)
end
