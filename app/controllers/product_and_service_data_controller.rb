class ProductAndServiceDataController < ApplicationController

  include MainConcern
  arguable model_class: ProductAndServiceDatum
  load_and_authorize_resource

  def update

    begin

      if !@model.update product_and_service_datum_params
        return render '_form'
      end
      
      if params[:commit] == t('helpers.action.update')
    
      elsif params[:commit] == t('helpers.action.email.private_send')
        IaqMailer.send_prod_and_serv_private_email(@model, date, current_user).deliver_now

        @model.on_analysis!
      elsif params[:commit] == t('helpers.action.email.send')
        IaqMailer.send_prod_and_serv_email(@model, date, current_user).deliver_now

        @model.finalized!
        @model.send_date = Date.today
      
      end

    rescue => exc
       @model.errors[:base] << handle_exception(exc, I18n.t('alert.email.error_sending'))
       return render '_form'
    end

    redirect_to send(@model.model_name.route_key + "_path"), notice: genderize_tag(@model, 'sent')

  end

  private ###########################################################################################

  def product_and_service_datum_params

    params.require(:product_and_service_datum).permit(:id, :competence, 
      product_and_service_weeks_attributes: [:id, :number, :start_date, :end_date, 
        attendance_data_attributes: [:id, :psychology, :physiotherapy, :plastic_surgery, :mesh_service, :gynecology, :occupational_therapy],
        return_data_attributes: [:id, :psychology, :physiotherapy, :plastic_surgery, :mesh_service, :gynecology, :occupational_therapy],
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
