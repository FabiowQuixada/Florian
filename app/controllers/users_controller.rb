class UsersController < ApplicationController

  include IndexAction
  include CreationActions
  include ModificationActions
  include StatusActions

  private ###################################################

  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :role_id, :active, :locale)
  end

  def index_query
    @q = User.ransack(params[:q])
    @q.result.eager_load(:role).order(:name).page(params[:page])
  end

  def edit_query
    model_class.eager_load(:role).find(params[:id])
  end
end
