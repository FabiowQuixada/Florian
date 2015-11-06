class UsersController < ApplicationController

  include MainControllerConcern
  arguable model_class: User#, params_validation: method(:user_params)

  load_and_authorize_resource
  before_filter :authenticate_user!

  def create
    @user = User.new user_params

    if @user.save
      redirect_to users_path, notice: genderize_tag(@user, 'created')
    else
      render 'new'
    end
  end

  def update
    @model = User.find params[:id]

      successfully_updated = if needs_password?(@model, user_params)
                           @user.update(user_params)
                         else
                           @user.update_without_password(user_params)
                         end

    if @model.update user_params
      redirect_to users_path, notice: genderize_tag(@model, 'updated')
    else
      render 'edit'
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
