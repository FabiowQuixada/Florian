class CompaniesController < ApplicationController

  include MainControllerConcern
  arguable model_class: Company
  load_and_authorize_resource

  private

  def params_validation
    company_params
  end

  def company_params
    params.require(:company).permit(:id, :simple_name, :long_name, :cnpj, :address, :cep,
      :neighborhood, :city, :state, :email_address, :website, :category, :donation, :first_parcel,
       :last_parcel, :remark, :parcel_frequency, :total_period,
       :resp_name, :resp_cellphone,:resp_phone, :resp_fax, :resp_role, :resp_email_address,
         :assistant_name, :assistant_phone, :assistant_cellphone, :assistant_email_address,
         :financial_name, :financial_phone, :financial_cellphone, :financial_email_address, :group,
         donations_attributes: [:id, :value, :donation_date, :remark]
         )
  end

  before_filter :after_new, only: [:new]
  before_filter :after_edit, only: [:edit]

  def after_new
    @model.city = "Fortaleza"
    @model.state = "CE"

  end

    def after_edit
    @model.donations.build

  end

  def order_attribute
    "trading_name"
  end
end
