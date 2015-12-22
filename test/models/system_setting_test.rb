require "test_helper"

class SystemSettingTest < ActiveSupport::TestCase
  def system_setting
    @system_setting ||= SystemSetting.new
  end

  def test_valid
    assert system_setting.valid?
  end
end
