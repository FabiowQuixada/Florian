class Donation < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  after_initialize :init
  before_save :default_values


  # Relationships
  belongs_to :maintainer


  # Validations
  validate :validate_model
  validates :donation_date, presence: true


  # Methods
  def init
    self.donation_date ||= Time.now
  end

  def value=(val)
    monetize :value, val
  end

  def to_s
    "#{maintainer.name} (#{I18n.l donation_date})"
  end

  def default_values
    self.value ||= 0.00
  end

  def validate_model
    errors.add :donation_date, blank_error_message('date') unless donation_date.is_a? Date
    errors.add :donation_date, I18n.t('errors.donation.value_or_remark') if no_value? && no_remark?
  end

  private

  def no_value?
    value.nil? || value == 0
  end

  def no_remark?
    remark.nil? || remark.empty?
  end
end
