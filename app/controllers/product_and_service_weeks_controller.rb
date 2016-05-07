class ProductAndServiceWeeksController < ApplicationController

  include MainConcern
  arguable model_class: ProductAndServiceDatum
  load_and_authorize_resource

  def update_and_send

    @week = ProductAndServiceWeek.find(params[:product_and_service_week][:id])
    @model = @week.product_and_service_datum
    @breadcrumbs = @model.breadcrumb_path.merge Hash[t('helpers.action.edit') => ""]
    @breadcrumbs = @breadcrumbs.merge @model.breadcrumb_suffix unless @model.breadcrumb_suffix.nil?

    if @week.update product_and_service_week_params

      begin

       IaqMailer.send_weekly_prod_and_serv_email(@week, current_user).deliver_now
       #@model.finalized!

     rescue => exc
       @model.errors[:base] << handle_exception(exc, I18n.t('alert.email.error_sending'))
       return render 'product_and_service_data/_form'
     end
   else
    @week.errors.messages.map { |key, value| @model.errors[key] << @week.errors.messages[key].first }
    return render 'product_and_service_data/_form'
  end

  redirect_to send(@model.model_name.route_key + "_path"), notice: genderize_tag(@model, 'sent')

end

  def send_clients

    #byebug

    @week = ProductAndServiceWeek.find params[:id]
    @model = @week.product_and_service_datum
    @breadcrumbs = @model.breadcrumb_path.merge Hash[t('helpers.action.edit') => ""]
    @breadcrumbs = @breadcrumbs.merge @model.breadcrumb_suffix unless @model.breadcrumb_suffix.nil?

    begin
      if @week.update product_and_service_week_params
        IaqMailer.send_monthly_prod_and_serv_email(@week, current_user).deliver_now
        #@model.on_analysis!
      else
        @week.errors.messages.map { |key, value| @model.errors[key] << @week.errors.messages[key].first }
        return render 'product_and_service_data/_form'
      end

    rescue => exc
       @model.errors[:base] << handle_exception(exc, I18n.t('alert.email.error_sending'))
       return render '_form'
    end

    redirect_to send(@model.model_name.route_key + "_path"), notice: genderize_tag(@model, 'sent')

  end

  private ###########################################################################################

  def product_and_service_week_params

    params.require(:product_and_service_week).permit(:id, :number, :start_date, :end_date, 
      service_data_attributes: [:id, :service_type, :psychology, :physiotherapy, :plastic_surgery, :mesh, :gynecology, :occupational_therapy],
      product_data_attributes: [:id, :mesh, :cream, :protector, :silicon, :mask, :foam, :skin_expander, :cervical_collar])
  end

end
