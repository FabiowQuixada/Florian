class ProductAndServiceWeek < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper


  # Constants
  TOTALS_NUMBER = 6
  FINAL_NUMBER = 7
  HELPER_NUMBER = -1


  # Relationships
  belongs_to :product_and_service_datum
  has_many :service_data, -> { order('service_type') }, class_name: 'ServiceData', dependent: :destroy
  has_one :product_data, class_name: 'ProductData', dependent: :destroy
  accepts_nested_attributes_for :service_data, :product_data


  # Validations
  validates :number, :start_date, :end_date, presence: true
  validate :validate_model


  # Methods
  def validate_model
    errors.add(:start_date, error_message('period_is_mandatory')) unless end_date && start_date
    errors.add(:start_date, error_message('invalid_period')) if invalid_range?

    validate_prod
    validate_servs
  end

  def service_qty
    sum = 0
    service_data.each { |service| sum += service.qty }
    sum
  end

  def product_qty
    product_data.qty
  end

  def attendances
    service_data[0]
  end

  def returns
    service_data[1]
  end

  def model_gender
    'f'
  end

  def common?
    0 <= number && number <= 5
  end

  def totals?
    number == TOTALS_NUMBER
  end

  def final?
    number == FINAL_NUMBER
  end

  def helper?
    index == HELPER_NUMBER
  end

  def index
    number - 1
  end

  def title
    I18n.t('activerecord.models.product_and_service_week.one') + " #{number}"
  end

  def period
    I18n.t('helpers.from') + " #{start_date} " + I18n.t('helpers.to') + " #{end_date}"
  end

  private

  after_initialize do
    unless persisted?
      if service_data.empty?
        service_data.new
        service_data.new
      end

      attendances.service_type ||= ServiceData.service_types[:attendance]
      returns.service_type ||= ServiceData.service_types[:return]

      self.product_data ||= ProductData.new

      self.start_date ||= Date.today
      self.end_date ||= Date.today

      self.number ||= -1
    end
  end

  def invalid_range?
    self.end_date && self.start_date && self.end_date < self.start_date
  end

  def validate_prod
    errors.add(:product_data, error_message('all_products_are_mandatory')) unless product_data.validate_model
  end

  def validate_servs
    errors.add(:attendance_data, error_message('all_attendances_are_mandatory')) unless attendances.validate_model
    errors.add(:return_data, error_message('all_returns_are_mandatory')) unless returns.validate_model
  end

  def error_message(tag)
    I18n.t("errors.product_and_service_datum.#{tag}", week_number: number.to_s)
  end

end
