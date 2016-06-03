class ProductAndServiceWeek < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper


  # Relationships
  belongs_to :product_and_service_datum
  has_many :service_data, -> { order("service_type") }, :class_name => 'ServiceData', dependent: :destroy
  has_one :product_data, :class_name => 'ProductData', dependent: :destroy
  accepts_nested_attributes_for :service_data, :product_data


  # Validations
  validates :number, :start_date, :end_date, :presence => true
  validate :validate_model


  # Methods
  after_initialize do
    unless persisted?
      if self.service_data.empty?
        self.service_data.new :service_type => ServiceData.service_types[:attendance]
        self.service_data.new :service_type => ServiceData.service_types[:return]
      end

      self.product_data ||= ProductData.new

      self.start_date ||= Date.today
      self.end_date ||= Date.today

      self.number ||= -1
    end
  end

  def validate_model
    errors.add(:start_date, I18n.t('errors.product_and_service_datum.period_is_mandatory', week_number: number.to_s)) if !self.end_date or !self.start_date

    errors.add(:start_date, I18n.t('errors.product_and_service_datum.invalid_period', week_number: number.to_s)) if self.end_date and self.start_date and self.end_date < self.start_date

    errors.add(:attendance_data, I18n.t('errors.product_and_service_datum.all_attendances_are_mandatory', week_number: number.to_s)) if !self.service_data[0].validate_model
    errors.add(:return_data, I18n.t('errors.product_and_service_datum.all_returns_are_mandatory', week_number: number.to_s)) if !self.service_data[1].validate_model
    errors.add(:product_data, I18n.t('errors.product_and_service_datum.all_products_are_mandatory', week_number: number.to_s)) if !self.product_data.validate_model
  end

  def service_qty
    sum = 0
    self.service_data.each {|service| sum += service.qty}
    sum
  end

  def product_qty
    self.product_data.qty
  end

  def model_gender
    'f'
  end

end
