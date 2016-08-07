class RegistrationsController < Devise::RegistrationsController

  before_filter :authenticate_user!

  def create
    user = User.new user_params

    if user.save
      redirect_to users_path, notice: genderize_tag(user, 'created')
    else
      render 'new'
    end
  end

  def edit
    @model = current_user
  end

  def update
    prev_unconfirmed_email = current_user.unconfirmed_email if current_user.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(current_user, account_update_params)
    yield current_user if block_given?

    something resource_updated, prev_unconfirmed_email
  end

  private

  # TODO: Understand, refactor and rename this method!
  def something(resource_updated, prev_unconfirmed_email)
    if resource_updated
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

  def user_params
    params.require(:user).permit(:id, :name, :email, :role_id, :password, :password_confirmation, :signature, :current_password)
  end

  def needs_password?(params)
    params[:password].present?
  end

  def account_update_params
    params.require(:user).permit(:signature, :bcc, :email, :password, :password_confirmation, :current_password)
  end

  before_action :before_edit, only: [:edit, :update]

  def before_edit
    return redirect_to root_path, alert: I18n.t('error_pages.not_found.title') if current_user.guest?

    @breadcrumbs = Hash[t('helpers.profile') => '']
  end

end
