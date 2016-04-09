class Donation < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  after_initialize :init
  before_save :default_values
  usar_como_dinheiro :value


  # Relationships
  belongs_to :company


  # Validations
  validate :validate_model
  validates :donation_date, :company, :presence => true


  # Methods
  def init
      self.donation_date ||= Time.now
  end

  def default_values
    self.value ||= 0.00
  end

  def validate_model

    if ((value.nil? or value != '0,00') or (!remark.nil? or !remark.empty?)) and !donation_date.is_a?(Date)
      errors.add :donation_date, I18n.t('errors.donation.date_mandatory')
    elsif (value.nil? or value == '0,00') and (remark.nil? or remark.empty?) and donation_date.is_a?(Date)
      errors.add :donation_date, I18n.t('errors.donation.value_or_remark')
    end
  end

  def model_gender
    'f'
  end

end
