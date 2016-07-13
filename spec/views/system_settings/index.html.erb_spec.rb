require 'rails_helper'

describe 'system_settings/index', type: :view do
  let(:class_name) { SystemSetting }
  it_behaves_like 'an index view'
end
