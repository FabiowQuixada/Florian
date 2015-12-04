class UsersController < ApplicationController

  include MainConcern
  include StatusConcern
  arguable model_class: User
  load_and_authorize_resource

  private

  def params_validation
    user_params
  end

  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :role_id)
  end

  def needs_password?(user, params)
    params[:password].present?
  end

  def order_attribute
    "name"
  end

end
