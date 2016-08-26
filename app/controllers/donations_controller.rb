class DonationsController < ApplicationController

  include IndexAction
  include CreationActions
  include ModificationActions
  include DestroyAction

  def index
    @list = Donation.order order_attribute
    @month_list = []

    @list.each do |donation|
      month = I18n.localize(donation.donation_date, format: :competence).capitalize
      @month_list << month unless @month_list.include?(month)
    end

    @month = 'Dezembro/2015'
  end

  def create_and_new
    @model = Donation.new donation_params
    @breadcrumbs = Hash[@model.model_name.human(count: 2) => donations_path, t(@model.genderize('helpers.action.new')) => '']

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
