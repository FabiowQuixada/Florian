class SystemSettingsController < ApplicationController

  include MainConcern
  arguable model_class: SystemSetting
  load_and_authorize_resource
  before_action :before_all

  private ###########################

  def system_setting_params
    params.require(:system_setting).permit(:id, :user_id, :re_title, :re_body, :pse_recipients_array, :pse_private_recipients_array, :pse_day_of_month, :pse_title, :pse_body)
  end

  def before_all

    unless current_user.admin?
      if params[:action] == 'edit' && params[:id] != SystemSetting.find_by_user_id(current_user.id).id.to_s
        redirect_to url_for(controller: :errors, action: :not_found)
      elsif params[:action] == 'index'
        redirect_to(edit_system_setting_path(SystemSetting.find_by_user_id(current_user.id))) && return
      end
    end
  end
end
