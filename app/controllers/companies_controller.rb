class CompaniesController < ApplicationController

  include MainConcern
  arguable model_class: Company
  load_and_authorize_resource

  def update
    if @model.update send(@model.model_name.singular + '_params')
      destroy_donations
      destroy_contacts
      redirect_to send(@model.model_name.route_key + '_path'), notice: @model.was('updated')
    else
      render '_form'
    end
  end

  def contact_row
    contact = Contact.new contact_params

    render partial: 'contacts/contact', locals: { contact: contact }
  end

  def donation_row
    donation = Donation.new donation_params

    render partial: 'donations/donation', locals: { donation: donation }
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

  def donation_params
    params.require(:donation).permit(:id, :value, :donation_date, :remark)
  end

  def destroy_donations

    return if params[:donations_to_be_deleted].nil?

    params[:donations_to_be_deleted].split(',').each do |id|
      @model.donations.find(id).destroy
    end
  end

  def destroy_contacts

    return if params[:contacts_to_be_deleted].nil?

    params[:contacts_to_be_deleted].split(',').each do |id|
      @model.contacts.find(id).destroy
    end
  end

  def order_attribute
    'name'
  end
end
