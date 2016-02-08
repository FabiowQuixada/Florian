class ProductAndServiceEmailsController < ApplicationController

  include MainConcern
  arguable model_class: ProductAndServiceEmail
  load_and_authorize_resource

  def update

    @model = ProductAndServiceEmail.find params[:id]

    byebug

    date = check_competence

    begin

      if !@model.update product_and_service_email_params
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

  def product_and_service_email_params
    params.require(:product_and_service_email).permit(:id, :competence_date, :psychology, :physiotherapy, :plastic_surgery, :mesh_service, :gynecology, :occupational_therapy, :psychology_return, :physiotherapy_return, :plastic_surgery_return, :mesh_service_return, :gynecology_return, :occupational_therapy_return, :mesh, :cream, :protector, :silicon, :mask, :foam, :skin_expander, :cervical_collar)
  end

  def order_attribute
    "created_at DESC"
  end


  def check_competence

    competence = params[:product_and_service_email][:competence_date]

    begin
      date = Date.strptime("{ 1, " + competence[0..1] + ", " + competence[3,6] + "}", "{ %d, %m, %Y }")
    rescue Exception => exc
      raise IaqException.new(I18n.t('alert.email.invalid_competence'))
    end
  end

end
