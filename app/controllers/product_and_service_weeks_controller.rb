class ProductAndServiceWeeksController < ApplicationController

  # TODO: When exception is raised, input data is not reloaded

  def update_and_send
    return unless ok_to_update_and_send?
    perform_update_and_send
  rescue => exc
    @model.errors[:base] << handle_exception(exc, I18n.t('alert.email.error_sending'))
    redirect_to edit_product_and_service_datum_path @model
  end

  def send_to_analysis
    return unless ok_to_send_to_analysis?
    perform_send_to_analysis
  rescue => exc
    @model.errors[:base] << handle_exception(exc, I18n.t('alert.email.error_sending'))
    redirect_to edit_product_and_service_datum_path @model
  end

  def send_maintainers
    return unless ok_to_send_maintainers?
    perform_send_maintainers
  rescue => exc
    @model.errors[:base] << handle_exception(exc, I18n.t('alert.email.error_sending'))
    redirect_to edit_product_and_service_datum_path @model
  end

  private ###########################################################################################

  def product_and_service_week_params
    params.require(:product_and_service_week).permit(:id, :number, :start_date, :end_date,
                                                     service_data_attributes: [:id, :service_type, :psychology, :physiotherapy, :plastic_surgery, :mesh, :gynecology, :occupational_therapy],
                                                     product_data_attributes: [:id, :mesh, :cream, :protector, :silicon, :mask, :foam, :skin_expander, :cervical_collar])
  end

  before_action :before_send_emails, only: [:update_and_send, :send_to_analysis, :send_maintainers]

  def before_send_emails
    @week = ProductAndServiceWeek.find params[:product_and_service_week][:id]
    @model = @week.product_and_service_datum
    @breadcrumbs = @model.breadcrumb_path.merge Hash[@model.alias => '']
  end

  def ok_to_update_and_send?
    if @model.on_analysis? || @model.finalized?
      @model.errors[:base] << I18n.t('errors.product_and_service_datum.cant_send')
      render 'product_and_service_data/_form', status: :precondition_failed
      return false
    end

    true
  end

  def ok_to_send_to_analysis?
    unless @model.created?
      @model.errors[:base] << I18n.t('errors.product_and_service_datum.cant_send_to_analysis')
      render 'product_and_service_data/_form', status: :precondition_failed
      return false
    end

    true
  end

  def ok_to_send_maintainers?
    unless @model.on_analysis?
      @model.errors[:base] << I18n.t('errors.product_and_service_datum.cant_send_to_maintainers')
      render 'product_and_service_data/_form', status: :precondition_failed
      return false
    end

    true
  end

  def perform_update_and_send
    if @week.update product_and_service_week_params
      ProdServMailer.send_weekly_email(@week, current_user).deliver_now
      redirect_to product_and_service_data_path, notice: @model.was('sent')
    else
      add_week_errors_to_datum
      render 'product_and_service_data/_form', status: :unprocessable_entity
    end
  end

  def perform_send_to_analysis
    @model.on_analysis!

    if @week.update(product_and_service_week_params) && @model.save
      ProdServMailer.send_to_analysis(@week, current_user).deliver_now
      redirect_to product_and_service_data_path, notice: @model.was('sent')
    else
      add_week_errors_to_datum
      render 'product_and_service_data/_form', status: :unprocessable_entity
    end
  end

  def perform_send_maintainers
    @model.finalized!

    if @week.update(product_and_service_week_params) && @model.save
      ProdServMailer.send_monthly_email(@week, current_user).deliver_now
      redirect_to product_and_service_data_path, notice: @model.was('sent')
    else
      add_week_errors_to_datum
      render 'product_and_service_data/_form', status: :unprocessable_entity
    end
  end

  def add_week_errors_to_datum
    @week.errors.messages.map { |key| @model.errors[key] << @week.errors.messages[key].first }
  end

end
