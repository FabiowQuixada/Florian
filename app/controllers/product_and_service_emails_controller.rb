class ProductAndServiceEmailsController < ApplicationController

  include MainConcern
  arguable model_class: ProductAndServiceEmail
  load_and_authorize_resource

  def create

    @model = ProductAndServiceEmail.new product_and_service_email_params

    if !@model.save
      return render '_form'
    end

    begin

      IaqMailer.send_prod_and_serv_email(@model, current_user).deliver_now

     rescue => exc
       @model.errors[:base] << handle_exception(exc, I18n.t('alert.email.error_sending'))
       return render '_form'
     end

    redirect_to send(@model.model_name.route_key + "_path"), notice: genderize_tag(@model, 'sent')
  end

  # def send_test

  #   @model = ProductAndServiceEmail.new product_and_service_email_params

  #   if !@model.valid?
  #     return render '_form'
  #   end

  #   begin

  #     IaqMailer.send_prod_and_serv_test_email(@model, current_user).deliver_now

  #    rescue => exc
  #      @model.errors[:base] << handle_exception(exc, I18n.t('alert.email.error_sending_test'))
  #      return render '_form'
  #    end

  #   return render :json => {
  #       :message => genderize_tag(@model, 'test_sent')
  #     }
  # end

  private ###########################################################################################

  def product_and_service_email_params
    params.require(:product_and_service_email).permit(:id, :competence_date, :psychology, :physiotherapy, :plastic_surgery, :mesh_service, :gynecology, :occupational_therapy, :psychology_return, :physiotherapy_return, :plastic_surgery_return, :mesh_service_return, :gynecology_return, :occupational_therapy_return, :mesh, :cream, :protector, :silicon, :mask, :foam, :skin_expander, :cervical_collar)
  end

end
