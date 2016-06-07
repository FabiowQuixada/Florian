class Bill < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  usar_como_dinheiro :water
  usar_como_dinheiro :energy
  usar_como_dinheiro :telephone
  after_initialize :default_values


  # Validations
  validates :competence, presence: true, uniqueness: true
  validates :water, :energy, :telephone, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validate :validate_model


  # Methods
  def model_gender
    'f'
  end

  private

  def default_values
    self.competence ||= Date.today
    self.water ||= 0.00
    self.energy ||= 0.00
    self.telephone ||= 0.00
  end

  def validate_model
    self.competence = self.competence.change(day: 1) if self.competence
  end
end
