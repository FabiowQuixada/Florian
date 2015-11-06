class EmailsController < ApplicationController

  include MainControllerConcern
  arguable model_class: Email#, params_validation: method(:email_params)

  load_and_authorize_resource
  before_filter :authenticate_user!

  def index

    @model = Email.new
    @list = order_emails_by_date

    @breadcrumbs = Hash[@model.model_name.human(:count => 2) => ""]

    # TODO tipo de e-mail
    @recent_emails = EmailHistory.where("created_at >= :start_date AND send_type != 2",
      {start_date: Date.new - 10.days})

  end

  def create
    @model = Email.new email_params

    if @model.save
      redirect_to emails_path, notice: genderize_tag(@model, 'created')
    else
      render 'new'
    end
  end

  def update
    @model = Email.find params[:id]

    if @model.update email_params
      redirect_to emails_path, notice: genderize_tag(@model, 'updated')
    else
      render 'edit'
    end
  end

  def resend

    email = load_email

    begin

      date = check_competence

      if !email.valid?
        return render json: email.errors, status: :unprocessable_entity
      end

      IaqMailer.send_email(email, date, 1, current_user).deliver_now

      history = email.email_histories.last

      return render :json => {
        :message => genderize_tag(email, 'resent'),
        :date => l(history.created_at, format: :really_short),
        :company => email.company.simple_name,
        :value => ActionController::Base.helpers.number_to_currency(history.value),
        :type => history.send_type_desc,
        :user => history.user.name
      }

    rescue => exc
      exception_message = handle_exception exc, I18n.t('alert.email.error_resending')
      return render json: exception_message, status: :unprocessable_entity
    end
  end

  def send_test

    email = load_email

    begin
      date = check_competence

      if !email.valid?
        return render json: email.errors, status: :unprocessable_entity
      end

      IaqMailer.send_email(email, date, 2, current_user).deliver_now

      history = email.email_histories.last

      return render :json => {
        :message => genderize_tag(email, 'test_sent'),
        :date => l(history.created_at, format: :really_short),
        :company => email.company.simple_name,
        :value => ActionController::Base.helpers.number_to_currency(history.value),
        :type => history.send_type_desc,
        :user => history.user.name
      }

    rescue Exception => exc
      exception_message = handle_exception exc, I18n.t('alert.email.error_sending_test')
      return render json: exception_message, status: :unprocessable_entity
    end
  end


  def self.send_email_daily

    emails = Email.where(day_of_month: Time.now.day, active: true)

    emails.each do |email|
        IaqMailer.send_email(email, Date.today, 0, User.first).deliver_now
    end
  end

  private ###########################################################################################

  def email_params
    params.require(:email).permit(:id, :email_configuration_id, :body, :value, :day_of_month, :active, :company_id, :recipients_array, :receipt_text)
  end

  # TODO If the user wants to do an action with the (possibly unsaved) data on the screen
  def temp_email_params
    params.permit(:utf8, :_method, :authenticity_token, :commit, :id, :competence, { email: [:id, :email_configuration_id, :body, :value, :day_of_month, :active, :company_id, :recipients_array, :receipt_text] })
  end

  def order_emails_by_date

    emails = Email.all

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
    email = Email.find params[:id]

    if params[:email] && params[:email][:body]
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
end
