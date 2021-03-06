class ProductAndServiceDatum < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  enum status: [:created, :on_analysis, :finalized]


  # Relationships
  has_many :product_and_service_weeks, -> { order('number') }, dependent: :destroy
  alias_attribute :weeks, :product_and_service_weeks
  accepts_nested_attributes_for :product_and_service_weeks


  # Validations
  validates :status, :competence, presence: true
  validates :competence, uniqueness: true
  validate :validate_model
  validates :status, inclusion: { in: statuses.keys }


  # Methods
  after_initialize do
    if product_and_service_weeks.empty?
      (1..(NUMBER_OF_WEEKS + 2)).each do |i|
        product_and_service_weeks.new number: i
      end
    end

    self.competence ||= Date.today
  end

  def to_s
    I18n.localize(competence, format: :competence).capitalize
  end

  def can_edit?
    !finalized?
  end

  def status_desc
    I18n.t("enums.product_and_service_datum.status.#{status}")
  end

  def service_qty
    sum = 0
    weeks.each { |week| sum += week.service_qty if week.common? }
    sum
  end

  def product_qty
    sum = 0
    weeks.each { |week| sum += week.product_qty if week.common? }
    sum
  end

  def final_week
    weeks.last
  end

  private

  def validate_model
    self.competence = self.competence.change(day: 1) if self.competence
    errors.add(:weeks, I18n.t('errors.product_and_service_datum.weeks_qty', weeks: weeks.size)) if weeks.length != 7
    errors
  end

end
