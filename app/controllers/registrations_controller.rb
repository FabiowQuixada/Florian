class RegistrationsController < Devise::RegistrationsController


  #load_and_authorize_resource
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

    @model = current_user

    @model.password = 'l'

    @breadcrumbs = Hash[t('helpers.profile') => ""]
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    @breadcrumbs = Hash[t('helpers.profile') => ""]

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :email, :role_id)
  end

  def needs_password?(user, params)
    params[:password].present?
  end

end
