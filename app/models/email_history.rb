class EmailHistory < ActiveRecord::Base

  # Configuration
  usar_como_dinheiro :value
  enum send_type: [:auto, :resend, :test]


  # Relationships
  belongs_to :user
  belongs_to :receipt_email


  # Validations
  validates :value, :body, :receipt_email, :recipients_array, presence: true
  validates :send_type, inclusion: { in: send_types.keys }


  # Methods
  def send_type_desc
    I18n.t('activerecord.attributes.receipt_email.type_values.' + send_type.to_s)
  end
end
