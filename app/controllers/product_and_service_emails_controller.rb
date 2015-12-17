class ProductAndServiceEmailsController < ApplicationController

  include MainConcern
  arguable model_class: ProductAndServiceEmail
  load_and_authorize_resource

  def send_email

    @model = ProductAndServiceEmail.new product_and_service_email_params

    if @model.save
      redirect_to send(@model.model_name.route_key + "_path"), notice: genderize_tag(@model, 'created')
    else
      render '_form'
    end

    # begin

    #   date = check_competence

    #   if !email.valid?
    #     return render json: email.errors, status: :unprocessable_entity
    #   end

    #   IaqMailer.send_email(email, date, 1, current_user).deliver_now

    #   return render history_as_json(email, 'resent')

    # rescue => exc
    #   exception_message = handle_exception exc, I18n.t('alert.email.error_resending')
    #   return render json: exception_message, status: :unprocessable_entity
    # end
  end

  def send_test

    email = load_email

    begin
      date = check_competence

      if !email.valid?
        return render json: email.errors, status: :unprocessable_entity
      end

      IaqMailer.send_email(email, date, 2, current_user).deliver_now

      return render history_as_json(email, 'test_sent')

    rescue Exception => exc
      exception_message = handle_exception exc, I18n.t('alert.email.error_sending_test')
      return render json: exception_message, status: :unprocessable_entity
    end
  end

  private ###########################################################################################

  def params_validation
    product_and_service_email_params
  end

  def product_and_service_email_params
    params.require(:product_and_service_email).permit(:id, :competence_date, :psychology, :physiotherapy, :plastic_surgery, :mesh_service, :gynecology, :occupational_therapy, :psychology_return, :physiotherapy_return, :plastic_surgery_return, :mesh_service_return, :gynecology_return, :occupational_therapy_return, :mesh, :cream, :protector, :silicon, :mask, :foam, :skin_expander, :cervical_collar)
  end

end
