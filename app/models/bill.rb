class Bill < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  after_initialize :default_values


  # Validations
  validates :competence, presence: true
  validates :water, :energy, :telephone, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validate :validate_model

  # Methods
  def water=(val)
    monetize :water, val
  end

  def energy=(val)
    monetize :energy, val
  end

  def telephone=(val)
    monetize :telephone, val
  end

  def to_s
    I18n.localize(competence, format: :competence).capitalize
  end

  private #######################################################################################################

  def default_values
    self.competence ||= Date.today
    self.water ||= 0.00
    self.energy ||= 0.00
    self.telephone ||= 0.00
  end

  def validate_model
    self.competence ||= Date.today
    self.competence = self.competence.change(day: 1)

    attribute = I18n.t('activerecord.attributes.bill.competence')
    errors.add(:competence, I18n.t('errors.messages.taken', attribute: attribute)) if competence_already_taken?
  end

  def competence_already_taken?
    Bill.where("extract(month from competence) = #{competence.month} AND extract(year from competence) = #{competence.year} " + (id ? "AND id != #{id}" : '')).any?
  end
end
