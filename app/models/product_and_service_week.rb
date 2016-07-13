class ProductAndServiceWeek < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper


  # Relationships
  belongs_to :product_and_service_datum
  has_many :service_data, -> { order('service_type') }, class_name: 'ServiceData', dependent: :destroy
  has_one :product_data, class_name: 'ProductData', dependent: :destroy
  accepts_nested_attributes_for :service_data, :product_data


  # Validations
  validates :number, :start_date, :end_date, presence: true
  validate :validate_model


  # Methods
  after_initialize do
    unless persisted?
      if service_data.empty?
        service_data.new service_type: ServiceData.service_types[:attendance]
        service_data.new service_type: ServiceData.service_types[:return]
      end

      self.product_data ||= ProductData.new

      self.start_date ||= Date.today
      self.end_date ||= Date.today

      self.number ||= -1
    end
  end

  def validate_model
    errors.add(:start_date, I18n.t('errors.product_and_service_datum.period_is_mandatory', week_number: number.to_s)) unless self.end_date && self.start_date

    errors.add(:start_date, I18n.t('errors.product_and_service_datum.invalid_period', week_number: number.to_s)) if invalid_range?

    validate_prod_and_servs
  end

  # rubocop:disable all
  def validate_prod_and_servs
    errors.add(:attendance_data, I18n.t('errors.product_and_service_datum.all_attendances_are_mandatory', week_number: number.to_s)) unless service_data[0].validate_model
    errors.add(:return_data, I18n.t('errors.product_and_service_datum.all_returns_are_mandatory', week_number: number.to_s)) unless service_data[1].validate_model
    errors.add(:product_data, I18n.t('errors.product_and_service_datum.all_products_are_mandatory', week_number: number.to_s)) unless self.product_data.validate_model
  end
  # rubocop:enable all

  def service_qty
    sum = 0
    service_data.each { |service| sum += service.qty }
    sum
  end

  def product_qty
    self.product_data.qty
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

  private

  def invalid_range?
    self.end_date && self.start_date && self.end_date < self.start_date
  end

end
