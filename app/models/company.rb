require './lib/modules/company_module'

class Company < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  include CompanyModule
  usar_como_cnpj :cnpj


  # Relationships
  has_one :email
  has_many :donations, -> { order("donation_date") }, :dependent => :destroy
  has_many :contacts, -> { order("contact_type") }, :dependent => :destroy
  accepts_nested_attributes_for :donations, :allow_destroy => true, reject_if: :donation_rejectable?
  accepts_nested_attributes_for :contacts


  # Validations
  validates :trading_name, :name, uniqueness: true
  validate :unique_cnpj
  validate :contact_qty
  validates :trading_name, :name, :cnpj, :address, :category, :group, :presence => true
  validates :category, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3, only_integer: true }
  validates :group, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 4, only_integer: true }
  validates :contract, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3, only_integer: true }, allow_nil: true
  validates :payment_frequency, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 8, only_integer: true }, allow_nil: true



  # Methods
  after_initialize do
    if self.contacts.empty?
      for i in 0..2
         self.contacts.new(contact_type: i)
      end
    end
  end

  def gender
    'f'
  end

def unique_cnpj
    if self.cnpj and !self.cnpj.to_s.empty? and Company.where(cnpj: self.cnpj).where('id <> ?', self.id || 0).first
      errors.add(:cnpj, I18n.t('errors.company.unique_cnpj'))
    end
end

def contact_qty
  if contacts.size < 1 or contacts.size > 3
    errors.add(:contacts, 'Número de contatos inválidos: ' + contacts.size)
  end
end

def group_desc
  GROUPS[group-1].first unless GROUPS[group-1].nil?
  end

  def category_desc
    CATEGORIES[category-1].first unless CATEGORIES[category-1].nil?
  end

  def payment_frequency_desc
  PARCEL_FREQUENCIES[parcel_frequency-1].first unless PARCEL_FREQUENCIES[parcel_frequency-1].nil?
  end

  def donation_rejectable?(att)
    (att['value'].nil? or att['value'] == '0,00') && (att['donation_date'].nil? or !att['donation_date'].is_a?(Date)) && (att['remark'].nil? or att['remark'].blank?)
  end

end
