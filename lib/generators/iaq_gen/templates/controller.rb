class ControllerNameController < ApplicationController

  include MainConcern
  arguable model_class: ModelName
  load_and_authorize_resource

  private

  def params_validation
    model_name_params
  end

  def model_name_params
    params.require(:model_name).permit(<< attributes >>)
  end

end
