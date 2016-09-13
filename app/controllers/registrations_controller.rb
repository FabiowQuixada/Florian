class RegistrationsController < Devise::RegistrationsController

  before_filter :authenticate_user!

  def update
    return redirect_to root_path, alert: t('errors.unpermitted_action'), status: :unauthorized if Rails.env.showcase?

    prev_unconfirmed_email = current_user.unconfirmed_email if current_user.respond_to?(:unconfirmed_email)

    yield current_user if block_given?

    redirect prev_unconfirmed_email
  end

  private ################################

  def redirect(prev_unconfirmed_email)
    if resource_updated?
      custom_flash_key_message prev_unconfirmed_email
      sign_in resource_name, current_user, bypass: true
      respond_with current_user, location: after_update_path_for(current_user)
    else
      clean_up_passwords current_user
      respond_with current_user
    end
  end

  def custom_flash_key_message(prev_unconfirmed_email)
    return unless is_flashing_format?

    flash_key = if update_needs_confirmation?(current_user, prev_unconfirmed_email)
                  :update_needs_confirmation
                else
                  :updated
                end

    set_flash_message :notice, flash_key
  end

  def system_setting_params
    params[:user].require(:system_setting).permit(:id, :user_id, :re_title, :re_body, :pse_recipients_array, :pse_private_recipients_array, :pse_title, :pse_body)
  end

  def account_update_params
    params.require(:user).permit(:signature, :bcc, :email, :password, :password_confirmation, :current_password)
  end

  before_action :before_edit, only: [:edit, :update]

  def before_edit
    @model = current_user
    @breadcrumbs = Hash[t('helpers.profile') => '']
  end

  def resource_updated?
    current_user.system_setting.update(system_setting_params) && update_resource(current_user, account_update_params)
  end

end
