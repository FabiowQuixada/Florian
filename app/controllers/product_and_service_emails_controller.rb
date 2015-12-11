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

byebug

    product_and_service_email_params
  end

  def product_and_service_email_params
    params.require(:product_and_service_email).permit(:id, :competence_date, :psychology, :physiotherapy, :plastic_surgery, :mesh_service, :gynecology, :occupational_therapy, :psychology_return, :physiotherapy_return, :plastic_surgery_return, :mesh_service_return, :gynecology_return, :occupational_therapy_return, :mesh, :cream, :protector, :silicon, :mask, :foam, :skin_expander, :cervical_collar)
  end

  # TODO If the user wants to do an action with the (possibly unsaved) data on the screen
  def temp_email_params
    params.permit(:utf8, :_method, :authenticity_token, :commit, :id, :competence, { email: [:id, :email_configuration_id, :body, :value, :day_of_month, :active, :company_id, :recipients_array, :receipt_text] })
  end

  def order_emails_by_date

    emails = ProductAndServiceEmail.all

    this_month_emails = Array.new
    next_month_emails = Array.new

    emails.each do |email|
      if email.current_month
        this_month_emails << email
      else
        next_month_emails << email
      end
    end

    this_month_emails.sort! { |a,b| a.day_of_month <=> b.day_of_month }
    next_month_emails.sort! { |a,b| a.day_of_month <=> b.day_of_month }

    next_month_emails = next_month_emails.sort_by do |item|
      item[:day_of_month]
    end

    this_month_emails + next_month_emails

  end

  def load_email

    # If there's anything other than the id, load it from the parameters
    # Else, load it from the database
    email = ProductAndServiceEmail.find params[:id]

    if !params[:email_id]
      email.assign_attributes email_params
    end

    email
  end

  def check_competence
    begin
      date = Date.strptime("{ 1, " + params[:competence][0..1] + ", " + params[:competence][3,6] + "}", "{ %d, %m, %Y }")
    rescue Exception => exc
      raise IaqException.new(I18n.t('alert.email.invalid_competence'))
    end
  end

  def history_as_json(email, type)

    history = email.email_histories.last

    return :json => {
        :message => genderize_tag(email, type),
        :date => l(history.created_at, format: :really_short),
        :company => email.company.trading_name,
        :value => ActionController::Base.helpers.number_to_currency(history.value),
        :type => history.send_type_desc,
        :user => history.user.name
      }
  end

end
