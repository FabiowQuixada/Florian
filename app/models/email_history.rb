class EmailHistory < ActiveRecord::Base

  # Configuration
  usar_como_dinheiro :value


  enum send_type: { auto: 0, resend: 1, test: 2 }


  # Relationships
  belongs_to :user
  belongs_to :receipt_email


  # Methods
  def self.types(hash = {})
    type_values.keys.each { |key| hash[key] = I18n.t("activerecord.attributes.email.type_values.#{key}") }
    hash
  end

  def send_type_desc

    I18n.t("activerecord.attributes.receipt_email.type_values." + send_type)
  end
end
