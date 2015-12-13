class Contact < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper

  validates :telephone, length: { is: 14, :message => I18n.t('errors.contact.invalid_telephone') }, :allow_blank => true
  validates :celphone, length: { in: 14..16, :message => I18n.t('errors.contact.invalid_celphone') }, :allow_blank => true
end
