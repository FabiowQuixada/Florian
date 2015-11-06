class RolesController < ApplicationController

  include MainControllerConcern
  arguable model_class: Role#, params_validation: method(:role_params)

  load_and_authorize_resource
  before_filter :authenticate_user!

  def create
    @model = Role.new role_params

    if @model.save
      redirect_to emails_path, notice: genderize_tag(@model, 'created')
    else
      render 'new'
    end
  end

  def update
    if @model.update(role_params)
      redirect_to @model, notice: genderize_tag(@model, 'updated')
    else
      render :edit
    end
  end

  private

    def role_params
      params.require(:role).permit(:name, :description)
    end
end
