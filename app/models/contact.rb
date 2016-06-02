class Contact < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper

  enum contact_type: [ :"Responsável", :"Secretária", :"Setor Financeiro" ]


  # Relationships
  belongs_to :company

  # Validations
  validates :company, presence: true
  validates :telephone, format: { with: PHONE_FORMAT, message: I18n.t('errors.contact.invalid_telephone')}, :allow_blank => true
  validates :celphone, format: { with: PHONE_FORMAT, message: I18n.t('errors.contact.invalid_celphone')}, :allow_blank => true
  validates :fax, format: { with: PHONE_FORMAT, message: I18n.t('errors.contact.invalid_fax')}, :allow_blank => true
  validates :contact_type, inclusion: {in: contact_types.keys}
end
