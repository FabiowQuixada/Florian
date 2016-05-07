class ProductAndServiceDataController < ApplicationController

  include MainConcern
  arguable model_class: ProductAndServiceDatum
  load_and_authorize_resource

  private ###########################################################################################

  def product_and_service_datum_params

    params.require(:product_and_service_datum).permit(:id, :competence, 
      product_and_service_weeks_attributes: [:id, :number, :start_date, :end_date, 
        service_data_attributes: [:id, :service_type, :psychology, :physiotherapy, :plastic_surgery, :mesh, :gynecology, :occupational_therapy],
        product_data_attributes: [:id, :mesh, :cream, :protector, :silicon, :mask, :foam, :skin_expander, :cervical_collar]])
  end

  def order_attribute
    "created_at DESC"
  end


  def check_competence

    competence = params[:product_and_service_datum][:competence]

    begin
      Date.strptime("{ 1, " + competence[0..1] + ", " + competence[3,6] + "}", "{ %d, %m, %Y }")
    rescue Exception => exc
      byebug
      raise IaqException.new(I18n.t('alert.email.invalid_competence'))
    end
  end

end
