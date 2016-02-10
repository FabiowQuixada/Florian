class BillsController < ApplicationController

  include MainConcern
  arguable model_class: Bill
  load_and_authorize_resource

  private

  def params_validation
    bill_params
  end

  def bill_params
    params.require(:bill).permit(:id, :competence, :water, :energy, :telephone)
  end

  def order_attribute
    "competence DESC"
  end

end
