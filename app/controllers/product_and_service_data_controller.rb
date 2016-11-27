class ProductAndServiceDataController < ApplicationController

  include IndexAction
  include CreationActions
  include ModificationActions
  include DestroyAction

  private ###########################################################################################

  def product_and_service_datum_params
    # params[:product_and_service_datum][:competence] = formatted_date params[:product_and_service_datum][:competence]
    params.require(:product_and_service_datum).permit(:id, :competence,
                                                      product_and_service_weeks_attributes: [:id, :number, :start_date, :end_date,
                                                                                             service_data_attributes: [:id, :psychology, :physiotherapy, :plastic_surgery, :mesh, :gynecology, :occupational_therapy],
                                                                                             product_data_attributes: [:id, :mesh, :cream, :protector, :silicon, :mask, :foam, :skin_expander, :cervical_collar]])
  end

  def index_sorting_method
    ProductAndServiceDatum.order('competence DESC').page(params[:page])
  end

end
