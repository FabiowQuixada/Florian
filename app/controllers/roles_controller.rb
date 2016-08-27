class RolesController < ApplicationController

  include IndexAction
  include CreationActions
  include ModificationActions
  include DestroyAction
  include StatusActions

  private #################################################

  def role_params
    params.require(:role).permit(:name, :description)
  end

  def index_sorting_method
    Role.order :name
  end
end
