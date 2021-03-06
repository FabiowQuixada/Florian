class MaintainersController < ApplicationController

  include IndexAction
  include CreationActions
  include ModificationActions
  include DestroyAction

  def create
    @model = model_class.new model_params
    @model.donations.each { |donation| donation.maintainer = @model }

    if @model.save
      redirect_to model_index_path, notice: @model.was('created')
    else
      render '_form'
    end
  end

  private #############################################

  def maintainer_params
    params[:maintainer][:first_parcel] = formatted_date params[:maintainer][:first_parcel]
    params.require(:maintainer).permit(:id, :entity_type, :name, :registration_name, :cpf, :cnpj, :address, :cep,
                                       :neighborhood, :city, :state, :email_address, :website, :category, :donation, :first_parcel, :payment_frequency, :contract, :remark, :payment_period, :group,
                                       :donations_to_be_deleted, :contacts_to_be_deleted,
                                       donations_attributes: [:id, :value, :donation_date, :remark],
                                       contacts_attributes: [:id, :name, :position, :telephone, :celphone, :email, :fax])
  end

  def index_query
    @q = Maintainer.ransack(params[:q])
    @q.result.order(:name).page(params[:page])
  end

  def edit_query
    model_class.eager_load([:donations, :contacts, :audits]).find(params[:id])
  end
end
