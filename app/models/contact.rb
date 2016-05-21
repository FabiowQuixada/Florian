class Contact < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper


  # Validations
  validates :telephone, format: { with: PHONE_FORMAT, message: I18n.t('errors.contact.invalid_telephone')}, :allow_blank => true
  validates :celphone, format: { with: PHONE_FORMAT, message: I18n.t('errors.contact.invalid_celphone')}, :allow_blank => true
  validates :fax, format: { with: PHONE_FORMAT, message: I18n.t('errors.contact.invalid_fax')}, :allow_blank => true
  validates :contact_type, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 2, only_integer: true }
end
