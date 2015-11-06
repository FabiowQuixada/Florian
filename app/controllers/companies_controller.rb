class CompaniesController < ApplicationController

  include MainControllerConcern
  arguable model_class: Company#, params_validation: method(:company_params)

  load_and_authorize_resource

  def company_params
    params.require(:company).permit(:simple_name, :long_name)
  end
end
