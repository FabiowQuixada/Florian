class Company < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  include CompanyEnumHelper
  usar_como_cnpj :cnpj
  usar_como_cpf :cpf
  after_initialize :default_values
  attr_accessor :donations_to_be_deleted
  attr_accessor :contacts_to_be_deleted

  enum entity_type: [:company, :person]
  enum category: [:low, :medium, :high]
  enum group: [:maintainer, :punctual, :negative, :deactivated]
  enum payment_frequency: [:undefined, :diary, :weekly, :monthly, :bimonthly, :semiannually, :annually, :other]
  enum contract: [:with_contract, :no_contract, :contract_and_additive]


  # Relationships
  has_one :email
  has_many :donations, -> { order('donation_date') }, dependent: :destroy
  has_many :contacts, -> { order('id') }, dependent: :destroy
  accepts_nested_attributes_for :donations, allow_destroy: true, reject_if: :donation_rejectable?
  accepts_nested_attributes_for :contacts


  # Validations
  validates :registration_name, uniqueness: true, if: :company?, allow_blank: true
  validate :unique_cnpj
  validate :unique_cpf
  validates :entity_type, presence: true
  validates :registration_name, :cnpj, presence: true, if: :company?
  validates :cpf, presence: true, if: :person?
  validates :name, presence: true, uniqueness: true
  validates :address, :category, :group, presence: true

  validates :entity_type, inclusion: { in: entity_types.keys }, allow_nil: true
  validates :category, inclusion: { in: categories.keys }, allow_nil: true
  validates :group, inclusion: { in: groups.keys }, allow_nil: true
  validates :contract, inclusion: { in: contracts.keys }, allow_nil: true
  validates :payment_frequency, inclusion: { in: payment_frequencies.keys }, allow_nil: true


  # Methods
  def to_s
    name
  end

  def donation_rejectable?(att)
    donation = Donation.new(att)
    donation.company = self
    !donation.valid?
  end

  def update(params)

    destroy_contacts params
    destroy_donations params
    update_attributes params
  rescue
    raise ActiveRecord::Rollback

  end

  private

  # Uniqueness doesn't work, for some reason
  def unique_cnpj
    errors.add(:cnpj, I18n.t('errors.messages.taken', attribute: I18n.t('activerecord.attributes.company.cnpj'))) if cnpj && !cnpj.to_s.empty? && Company.where(cnpj: cnpj).where('id <> ?', id || 0).first
  end

  # Uniqueness doesn't work, for some reason
  def unique_cpf
    errors.add(:cpf, I18n.t('errors.messages.taken', attribute: I18n.t('activerecord.attributes.contact.cpf'))) if cpf && !cpf.to_s.empty? && Company.where(cpf: cpf).where('id <> ?', id || 0).first
  end

  def default_values
    self.city ||= DEFAULT_COMPANY_CITY
    self.state ||= DEFAULT_COMPANY_STATE
    self.entity_type ||= 'company'
  end

  def destroy_donations(params)
    return if params[:donations_to_be_deleted].nil?

    params[:donations_to_be_deleted].split(',').each do |id|
      donations.find(id).destroy
    end
  end

  def destroy_contacts(params)
    return if params[:contacts_to_be_deleted].nil?

    params[:contacts_to_be_deleted].split(',').each do |id|
      contacts.find(id).destroy
    end
  end

end
