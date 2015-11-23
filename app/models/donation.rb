class Donation < ActiveRecord::Base

  # Configuration
  audited
  include GenderHelper
  after_initialize :init
  before_save :default_values
  usar_como_dinheiro :value


  # Relationships
  belongs_to :company

  # Validations
  validate :validate_model


  # Methods
  def init
      self.donation_date  ||= Time.now
  end

  def default_values
    self.value ||= 0.00
  end

  def validate_model

    if ((value.nil? or value != '0,00') or (!remark.nil? or !remark.empty?)) and !donation_date.is_a?(Date)
      errors.add :donation_date, 'tem que ter data se tiver um ou outro preenchido'
    elsif (value.nil? or value == '0,00') and (remark.nil? or remark.empty?) and donation_date.is_a?(Date)
      errors.add :donation_date, 'data preenchida, mas pelo menos um dos dois tem q ter'
    end
  end

  def gender
    'f'
  end

end
