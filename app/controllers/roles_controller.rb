class RolesController < ApplicationController

  include MainConcern
  include StatusConcern
  arguable model_class: Role
  load_and_authorize_resource

  private

  def params_validation
    role_params
  end

    def role_params
      params.require(:role).permit(:name, :description)
    end


  def order_attribute
    "name"
  end
end
