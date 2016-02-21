class CompaniesController < ApplicationController

  include MainConcern
  arguable model_class: Company
  load_and_authorize_resource

  private #############################################

  def company_params
    params.require(:company).permit(:id, :entity_type, :name, :registration_name, :cpf, :cnpj, :address, :cep,
      :neighborhood, :city, :state, :email_address, :website, :category, :donation, :first_parcel,
       :last_parcel, :remark, :parcel_frequency, :total_period, :group,
         donations_attributes: [:id, :value, :donation_date, :remark],
         contacts_attributes: [:id, :name, :position, :telephone, :celphone, :email, :fax, :contact_type]
      )
  end

  before_filter :after_new, only: [:new]

  def after_new
    @model.city = "Fortaleza"
    @model.state = "CE"

  end

  def order_attribute
    "name"
  end
end
