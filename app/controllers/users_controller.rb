class UsersController < ApplicationController

  include IndexAction
  include CreationActions
  include ModificationActions
  include StatusActions

  private ###################################################

  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :role_id, :active, :locale)
  end

  def index_sorting_method
    @q = User.ransack(params[:q])
    @q.result.order(:name).page(params[:page])
  end
end
