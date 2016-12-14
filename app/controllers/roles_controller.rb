class RolesController < ApplicationController

  include IndexAction
  include CreationActions
  include ModificationActions
  include DestroyAction
  include StatusActions

  private #################################################

  def role_params
    params.require(:role).permit(:name, :description, :active)
  end

  def index_query
    @q = Role.ransack(params[:q])
    @q.result.order(:name).page(params[:page])
  end
end
