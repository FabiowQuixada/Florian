class DonationsController < ApplicationController

  include MainConcern
  arguable model_class: Donation
  load_and_authorize_resource

  def index
    @list = model_class.order order_attribute

    @month_list = []

    @list.each do |donation|
      month = I18n.localize(donation.donation_date, format: :competence).capitalize

      @month_list << month unless @month_list.include?(month)
    end

    @month = 'Dezembro/2015'
  end

  def filter

    before_index

    # @list = Donation.search params[:search]

    # @month = params[:month]
    # @company_id = params[:company_id]

    # redirect_to donations_path, :info => t('alert.query_results', :count => @list.size)
  end

  def create_and_new

    @model = model_class.new donation_params

    @breadcrumbs = Hash[@model.model_name.human(count: 2) => send(@model.model_name.route_key + '_path'), t(@model.genderize('helpers.action.new')) => '']

    if @model.save
      redirect_to new_donation_path, notice: genderize_tag(@model, 'created')
    else
      render '_form'
    end
  end

  private ###########################################################################################

  def donation_params
    params.require(:donation).permit(:value, :donation_date, :remark, :company_id, :user_id)
  end

  def order_attribute
    'donation_date DESC'
  end
end
