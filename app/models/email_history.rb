class EmailHistory < ActiveRecord::Base

  # Configuration
  include ModelHelper
  enum send_type: [:auto, :resend, :test]


  # Relationships
  belongs_to :user
  belongs_to :receipt_email


  # Validations
  validates :value, :body, :receipt_email, :recipients_array, presence: true
  validates :send_type, inclusion: { in: send_types.keys }


  # Methods
  def value=(val)
    monetize :value, val
  end

  def send_type_desc
    I18n.t("activerecord.attributes.receipt_email.type_values.#{send_type}")
  end

  def self.recent_emails
    all.where('created_at >= :start_date AND send_type != :send_type',
              start_date: Date.new - ReceiptEmail::RECENT_EMAILS_DAYS.days,
              send_type: EmailHistory.send_types[:test])
  end
end
