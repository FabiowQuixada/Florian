class MaintainersController < ApplicationController

  include IndexAction
  include CreationActions
  include ModificationActions
  include DestroyAction

  def contact_row
    render partial: 'contacts/contact', locals: { contact: Contact.new(contact_params) }
  end

  def donation_row
    render partial: 'donations/donation', locals: { donation: Donation.new(donation_params) }
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

  def contact_params
    params.require(:contact).permit(:id, :name, :position, :email_address, :telephone, :celphone, :fax)
  end

  def donation_params
    params[:donation][:donation_date] = Date.strptime(params[:donation][:donation_date], '%m/%d/%Y').strftime('%F')
    params.require(:donation).permit(:id, :value, :donation_date, :remark)
  end

  def index_sorting_method
    Maintainer.order(:name).page(params[:page])
  end
end
