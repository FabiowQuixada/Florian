class Contact < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper


  # Relationships
  belongs_to :company


  # Validations
  validate :validate_model
  validates :company, presence: true
  validates :telephone, format: { with: PHONE_FORMAT, message: I18n.t('errors.messages.invalid', attribute: I18n.t('activerecord.attributes.contact.telephone')) }, allow_blank: true
  validates :celphone, format: { with: CELPHONE_FORMAT, message: I18n.t('errors.messages.invalid', attribute: I18n.t('activerecord.attributes.contact.celphone')) }, allow_blank: true
  validates :fax, format: { with: PHONE_FORMAT, message: I18n.t('errors.messages.invalid', attribute: I18n.t('activerecord.attributes.contact.fax')) }, allow_blank: true


  private

  def validate_model
    errors.add :name, I18n.t('errors.contact.all_empty') if no_attrs_filled?
  end

  def no_attrs_filled?
    not_filled?(name) && not_filled?(position) && not_filled?(email_address) && not_filled?(telephone) && not_filled?(celphone) && not_filled?(fax)
  end

  def not_filled?(attr)
    attr.nil? || attr == ''
  end
end
