require "test_helper"

class SystemSettingsControllerTest < ActionController::TestCase
  def system_setting
    @system_setting ||= system_settings :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:system_settings)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("SystemSetting.count") do
      post :create, system_setting: {  }
    end

    assert_redirected_to system_setting_path(assigns(:system_setting))
  end

  def test_show
    get :show, id: system_setting
    assert_response :success
  end

  def test_edit
    get :edit, id: system_setting
    assert_response :success
  end

  def test_update
    put :update, id: system_setting, system_setting: {  }
    assert_redirected_to system_setting_path(assigns(:system_setting))
  end

  def test_destroy
    assert_difference("SystemSetting.count", -1) do
      delete :destroy, id: system_setting
    end

    assert_redirected_to system_settings_path
  end
end
