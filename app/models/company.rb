class Company < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  usar_como_cnpj :cnpj
  usar_como_cpf :cpf
  after_initialize :default_values

  
  enum entity_type: [:"Pessoa Jurídica", :"Pessoa Física"]
  enum category: [:"1 (Abaixo de R$ 300,00)", :"2 (Entre R$ 300,00 e R$ 600,00)", :"3 (Acima de R$ 600,00)"]
  enum group: [:"Mantenedora", :"Pontual", :"Negativa", :"Desativada"]
  enum payment_frequency: [:"Indeterminado", :"Diário", :"Semanal", :"Mensal", :"Bimestral", :"Semestral", :"Anual", :"Outro (Observações)"]
  enum contract: [:"Com contrato", :"Sem contrato", :"Contrato + Aditivo"]


  # Relationships
  has_one :email
  has_many :donations, -> { order("donation_date") }, :dependent => :destroy
  has_many :contacts, -> { order("contact_type") }, :dependent => :destroy
  accepts_nested_attributes_for :donations, :allow_destroy => true, reject_if: :donation_rejectable?
  accepts_nested_attributes_for :contacts


  # Validations
  validates :registration_name, uniqueness: true, :allow_blank => true, if: :company?
  validates :name, uniqueness: true, :allow_blank => true
  validate :unique_cnpj
  validate :unique_cpf
  validate :contact_qty
  validates :entity_type, :presence => true
  validates :registration_name, :cnpj, :presence => true, if: :company?
  validates :cpf, :presence => true, if: :person?
  validates :name, :presence => true
  validates :address, :category, :group, :presence => true

  validates :entity_type, inclusion: {in: entity_types.keys}, :allow_nil => true
  validates :category, inclusion: {in: categories.keys}, :allow_nil => true
  validates :group, inclusion: {in: groups.keys}, :allow_nil => true
  validates :contract, inclusion: {in: contracts.keys}, :allow_nil => true
  validates :payment_frequency, inclusion: {in: payment_frequencies.keys}, :allow_nil => true
  

  # Methods
  after_initialize do
    if self.contacts.empty?
      for i in 0..2
         self.contacts.new(contact_type: i)
      end
    end
  end

  def model_gender
    'f'
  end

  def contact_qty
    errors.add(:contacts, I18n.t('errors.company.contacts', contacts: contacts.size)) if contacts.size != 3
  end

  def person?
    self.entity_type == "Pessoa Física"
  end

  def company?
    self.entity_type == "Pessoa Jurídica"
  end

  def donation_rejectable?(att)
    (att['value'].nil? or att['value'] == '0,00') && (att['donation_date'].nil? or !att['donation_date'].is_a?(Date)) && (att['remark'].nil? or att['remark'].blank?)
  end

  def breadcrumb_suffix
    Hash[name => 'send(self.model_name.route_key + "_path")']
  end

  private 

  def unique_cnpj
      if self.cnpj and !self.cnpj.to_s.empty? and Company.where(cnpj: self.cnpj).where('id <> ?', self.id || 0).first
        errors.add(:cnpj, I18n.t('errors.company.unique_cnpj'))
      end
  end

  def unique_cpf
      if self.cpf and !self.cpf.to_s.empty? and Company.where(cpf: self.cpf).where('id <> ?', self.id || 0).first
        errors.add(:cpf, I18n.t('errors.company.unique_cpf'))
      end
  end

  def unique_name_message
    if person?
      I18n.t('errors.company.name')
    else
      I18n.t('errors.company.registration_name')
    end
  end

  def default_values
    self.city ||= DEFAULT_COMPANY_CITY
    self.state ||= DEFAULT_COMPANY_STATE
  end

end
