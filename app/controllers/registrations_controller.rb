class RegistrationsController < Devise::RegistrationsController

  before_filter :authenticate_user!

  def create
    @user = User.new user_params

    if @user.save
      redirect_to users_path, notice: genderize_tag(@user, 'created')
    else
      render 'new'
    end
  end

  def edit
    return redirect_to root_path, alert: I18n.t('error_pages.not_found.title') if current_user.guest?

    @model = current_user
    @breadcrumbs = Hash[t('helpers.profile') => '']
  end

  def update
    @breadcrumbs = Hash[t('helpers.profile') => '']

    something set_up_for_something
  end

  private

  # TODO: Understand and rename this method!
  # rubocop:disable all
  def set_up_for_something
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?

    [resource_updated, resource, prev_unconfirmed_email]
  end
  # rubocop:enable all

  def set_custom_flash_key_message
    return unless is_flashing_format?

    flash_key = if update_needs_confirmation?(resource, prev_unconfirmed_email)
                  :update_needs_confirmation
                else
                  :updated
                end
    set_flash_message :notice, flash_key
  end

  # TODO: Understand, refactor and rename this method!
  def something(resource_updated, resource, prev_unconfirmed_email)
    if resource_updated
      set_custom_flash_key_message resource, prev_unconfirmed_email
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def user_params
    params.require(:user).permit(:id, :name, :email, :role_id, :password, :password_confirmation, :signature, :current_password)
  end

  def needs_password?(_user, params)
    params[:password].present?
  end

  def account_update_params
    params.require(:user).permit(:signature, :bcc, :email, :password, :password_confirmation, :current_password)
  end

end
