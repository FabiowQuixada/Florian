class ProductAndServiceWeeksController < ApplicationController

  include MainConcern
  arguable model_class: ProductAndServiceDatum
  load_and_authorize_resource

  def update_and_send

    if @model.on_analysis? || @model.finalized?
      @model.errors[:base] << I18n.t('errors.product_and_service_datum.cant_send')
      return render 'product_and_service_data/_form', status: :unprocessable_entity
    end

    if @week.update product_and_service_week_params
      FlorianMailer.send_weekly_prod_and_serv_email(@week, current_user).deliver_now
      return redirect_to send(@model.model_name.route_key + '_path'), notice: genderize_tag(@model, 'sent')
    else
      @week.errors.messages.map { |key, _value| @model.errors[key] << @week.errors.messages[key].first }
      return render 'product_and_service_data/_form', status: :unprocessable_entity
    end

  rescue => exc
    @model.errors[:base] << handle_exception(exc, I18n.t('alert.email.error_sending'))
    return render 'product_and_service_data/_form', status: :internal_server_error
  end

  def send_to_analysis

    unless @model.created?
      @model.errors[:base] << I18n.t('errors.product_and_service_datum.cant_send_to_analysis')
      return render 'product_and_service_data/_form', status: :unprocessable_entity
    end

    @model.on_analysis!

    if @week.update(product_and_service_week_params) && @model.save
      FlorianMailer.send_prod_and_serv_to_analysis(@week, current_user).deliver_now
      return redirect_to send(@model.model_name.route_key + '_path'), notice: genderize_tag(@model, 'sent')
    else
      @week.errors.messages.map { |key, _value| @model.errors[key] << @week.errors.messages[key].first }
      return render 'product_and_service_data/_form', status: :unprocessable_entity
    end

  rescue => exc
    @model.errors[:base] << handle_exception(exc, I18n.t('alert.email.error_sending'))
    return render 'product_and_service_data/_form', status: :internal_server_error
  end

  def send_clients

    unless @model.on_analysis?
      @model.errors[:base] << I18n.t('errors.product_and_service_datum.cant_send_to_clients')
      return render 'product_and_service_data/_form', status: :unprocessable_entity
    end

    @model.finalized!

    if @week.update(product_and_service_week_params) && @model.save
      FlorianMailer.send_monthly_prod_and_serv_email(@week, current_user).deliver_now
      return redirect_to send(@model.model_name.route_key + '_path'), notice: genderize_tag(@model, 'sent')
    else
      @week.errors.messages.map { |key, _value| @model.errors[key] << @week.errors.messages[key].first }
      return render 'product_and_service_data/_form', status: :unprocessable_entity
    end

  rescue => exc
    @model.errors[:base] << handle_exception(exc, I18n.t('alert.email.error_sending'))
    return render 'product_and_service_data/_form', status: :internal_server_error
  end

  private ###########################################################################################

  def product_and_service_week_params
    params.require(:product_and_service_week).permit(:id, :number, :start_date, :end_date,
                                                     service_data_attributes: [:id, :service_type, :psychology, :physiotherapy, :plastic_surgery, :mesh, :gynecology, :occupational_therapy],
                                                     product_data_attributes: [:id, :mesh, :cream, :protector, :silicon, :mask, :foam, :skin_expander, :cervical_collar])
  end

  before_action :before_send_emails, only: [:update_and_send, :send_to_analysis, :send_clients]

  def before_send_emails
    @week = ProductAndServiceWeek.find params[:product_and_service_week][:id]
    @model = @week.product_and_service_datum
    @breadcrumbs = @model.breadcrumb_path.merge Hash[t('helpers.action.edit') => '']
    @breadcrumbs = @breadcrumbs.merge @model.breadcrumb_suffix unless @model.breadcrumb_suffix.nil?
  end

end
