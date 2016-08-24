class CompaniesController < ApplicationController

  include MainConcern
  arguable model_class: Company
  load_and_authorize_resource

  def update
    if @model.update send(@model.model_name.singular + '_params')
      redirect_to send(@model.model_name.route_key + '_path'), notice: @model.was('updated')
    else
      render '_form'
    end
  end

  def contact_row
    render partial: 'contacts/contact', locals: { contact: Contact.new(contact_params) }
  end

  def donation_row
    render partial: 'donations/donation', locals: { donation: Donation.new(donation_params) }
  end

  private #############################################

  def company_params
    params.require(:company).permit(:id, :entity_type, :name, :registration_name, :cpf, :cnpj, :address, :cep,
                                    :neighborhood, :city, :state, :email_address, :website, :category, :donation, :first_parcel, :payment_frequency, :contract, :remark, :payment_period, :group,
                                    :donations_to_be_deleted, :contacts_to_be_deleted,
                                    donations_attributes: [:id, :value, :donation_date, :remark],
                                    contacts_attributes: [:id, :name, :position, :telephone, :celphone, :email, :fax])
  end

  def contact_params
    params.require(:contact).permit(:id, :name, :position, :email_address, :telephone, :celphone, :fax)
  end

  def donation_params
    params.require(:donation).permit(:id, :value, :donation_date, :remark)
  end

  def order_attribute
    'name'
  end
end
