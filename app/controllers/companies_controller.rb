class CompaniesController < ApplicationController

  include MainConcern
  arguable model_class: Company
  load_and_authorize_resource

  def contact_row
    contact = Contact.new contact_params

    render partial: 'contacts/contact', locals: { contact: contact }
  end

  private #############################################

  def company_params
    params.require(:company).permit(:id, :entity_type, :name, :registration_name, :cpf, :cnpj, :address, :cep,
                                    :neighborhood, :city, :state, :email_address, :website, :category, :donation, :first_parcel, :payment_frequency, :contract, :remark, :payment_period, :group,
                                    donations_attributes: [:id, :value, :donation_date, :remark],
                                    contacts_attributes: [:id, :name, :position, :telephone, :celphone, :email, :fax, :contact_type])
  end

  def contact_params
    params.require(:contact).permit(:id, :name, :position, :email_address, :telephone, :celphone, :fax)
  end

  def order_attribute
    'name'
  end
end
