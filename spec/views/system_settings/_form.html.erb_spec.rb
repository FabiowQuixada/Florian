require 'rails_helper'

describe 'system_settings/_form', type: :view do
  before :each do
    current_user = User.first
    allow(view).to receive(:current_user).and_return(current_user)
  end

  let(:class_name) { SystemSetting }
  it_behaves_like 'an form view'
end
