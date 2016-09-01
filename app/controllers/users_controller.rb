class UsersController < ApplicationController

  include IndexAction
  include CreationActions
  include ModificationActions
  include StatusActions

  private ###################################################

  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :role_id)
  end

  def index_sorting_method
    User.order(:name).page(params[:page])
  end
end
