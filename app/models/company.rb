class Company < ActiveRecord::Base

  # Configuration
  audited
  include GenderHelper
  usar_como_cnpj :cnpj
  usar_como_dinheiro :value
  usar_como_dinheiro :donation


  # enum group: {"Mantenedora": 1, "Pontual": 2, "Negativa": 3, "Desativada": 4}
  # enum parcel_frequency:  {"Diário": 1, "Semanal": 2, "Mensal": 3, "Bimestral": 4, "Semestral": 5, "Anual": 6, "Outro (Observações)": 7}
  # enum category: {"I (Abaixo de R$ 300,00)": 1,"II (Entre R$ 300,00 e R$ 600,00)": 2, "III (Acima de R$ 600,00)": 3}


  # Relationships
  has_many :email
  has_many :company_donations
  belongs_to :configuration, :class_name => 'EmailConfiguration', :foreign_key => 'email_configuration_id'


  # Validations
  validates :simple_name, :long_name, uniqueness: true
  validate :cnpj_unico
  validates :simple_name, :long_name, :cnpj, :address, :category, :group, :presence => true
  validates :resp_phone, length: { is: 14 }, :allow_blank => true
  validates :resp_cellphone, length: { in: 14..16 }, :allow_blank => true
  validates :assistant_phone, length: { is: 14 }, :allow_blank => true
  validates :assistant_cellphone, length: { in: 14..16 }, :allow_blank => true
  validates :financial_phone, length: { is: 14 }, :allow_blank => true
  validates :financial_cellphone, length: { in: 14..16 }, :allow_blank => true


  # Methods
  def gender
    'f'
  end

#TODO
def cnpj_unico
    if self.cnpj and !self.cnpj.to_s.empty? and Company.where(cnpj: self.cnpj).where('id <> ?', self.id || 0).first
      errors.add(:cnpj, I18n.t('errors.company.unique_cnpj'))
    end
end

end
