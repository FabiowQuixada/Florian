class SystemSettingsController < ApplicationController

  include MainConcern
  arguable model_class: SystemSetting
  load_and_authorize_resource
  before_action :before_all

  def update

    return redirect_to url_for(controller: :errors, action: :not_found) if user_can_edit_settings current_user, params[:id].to_i

    if @model.update system_setting_params
      redirect_to system_settings_path, notice: @model.was('updated')
    else
      render '_form'
    end
  end

  private ###########################

  def system_setting_params
    params.require(:system_setting).permit(:id, :user_id, :re_title, :re_body, :pse_recipients_array, :pse_private_recipients_array, :pse_day_of_month, :pse_title, :pse_body)
  end

  def before_all

    return if current_user.admin?

    settings = SystemSetting.find_by_user_id(current_user.id)

    block_access?(settings) && return
    go_to_current_user_configs?(settings) && return
  end

  def invalid_edition?(action, settings, target_id)
    action == 'new' || (action == 'edit' && target_id != settings.id.to_s)
  end

  def user_can_edit_settings(user, settings_id)
    !user.admin? && settings_id != user.system_setting.id
  end

  def go_to_current_user_configs?(settings)
    return unless params[:action] == 'index'
    redirect_to edit_system_setting_path(settings)
    true
  end

  def block_access?(settings)
    return unless invalid_edition? params[:action], settings, params[:id]
    redirect_to root_path, alert: I18n.t('error_pages.not_found.title')
    true
  end
end
