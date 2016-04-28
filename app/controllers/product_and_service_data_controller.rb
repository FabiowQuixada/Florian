class ProductAndServiceDataController < ApplicationController

  include MainConcern
  arguable model_class: ProductAndServiceDatum
  load_and_authorize_resource

  def update_and_send

    byebug

    @week = ProductAndServiceWeek.new(params[:product_and_service_week])
    @model = @week.product_and_service_datum
    @breadcrumbs = @model.breadcrumb_path.merge Hash[t('helpers.action.edit') => ""]
    @breadcrumbs = @breadcrumbs.merge @model.breadcrumb_suffix unless @model.breadcrumb_suffix.nil?

    begin

        IaqMailer.send_monthly_prod_and_serv_email(@week, current_user).deliver_now
        #@model.on_analysis!

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
