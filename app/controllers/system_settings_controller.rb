class SystemSettingsController < ApplicationController

  include HelperMethods

  def index
    @model = SystemSetting.first
    @breadcrumbs = breadcrumbs
  end

  def update
    @model = SystemSetting.first

    if @model.update system_settings_params
      redirect_to system_settings_path, notice: @model.was('updated')
    else
      render 'index'
    end
  end

  private #############################################

  def system_settings_params
    params.require(:system_setting).permit(:id, :re_title, :re_body, :pse_recipients_array, :pse_private_recipients_array, :pse_title, :pse_body)
  end
end
