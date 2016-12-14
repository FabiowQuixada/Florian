class DonationsController < ApplicationController

  include IndexAction
  include CreationActions
  include ModificationActions
  include DestroyAction

  def create_and_new
    @model = Donation.new donation_params
    @breadcrumbs = Hash[@model.model_name.human(count: 2) => donations_path, t(@model.genderize('helpers.action.new')) => '']

    if @model.save
      redirect_to new_donation_path, notice: @model.was('created')
    else
      render '_form'
    end
  end

  private ###########################################################################################

  def donation_params
    params[:donation][:donation_date] = formatted_date params[:donation][:donation_date]
    params.require(:donation).permit(:value, :donation_date, :remark, :maintainer_id, :user_id)
  end

  def index_query
    format_filter_date :donation_date_gteq
    format_filter_date :donation_date_lteq
    @q = Donation.ransack(params[:q])
    @q.result.eager_load(:maintainer).order(donation_date: :desc).page(params[:page])
  end
end
