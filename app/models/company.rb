class Company < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  usar_como_cnpj :cnpj


  CATEGORIES = [["I (Abaixo de R$ 300,00)", 1],["II (Entre R$ 300,00 e R$ 600,00)", 2], ["III (Acima de R$ 600,00)", 3]]
  GROUPS = [["Mantenedora", 1], ["Pontual", 2], ["Negativa", 3], ["Desativada", 4]]
  PARCEL_FREQUENCIES = [["Indeterminado", 8], ["Diário", 1], ["Semanal", 2], ["Mensal", 3], ["Bimestral", 4], ["Semestral", 5], ["Anual", 6], ["Outro (Observações)", 7]]
  CONTRACTS = [["Com contrato", 1], ["Sem contrato", 2], ["Contrato + Aditivo", 3]]

  # Relationships
  has_one :email
  has_many :donations, -> { order("donation_date") }, :dependent => :destroy
  has_many :contacts, -> { order("contact_type") }, :dependent => :destroy
  accepts_nested_attributes_for :donations, :allow_destroy => true, reject_if: :donation_rejectable?
  accepts_nested_attributes_for :contacts#, reject_if: :contact_rejectable?


  # Validations
  validates :trading_name, :name, uniqueness: true
  validate :unique_cnpj
  validates :trading_name, :name, :cnpj, :address, :category, :group, :presence => true


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
