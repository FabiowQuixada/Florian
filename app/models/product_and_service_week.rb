require './lib/modules/prod_serv_module'

class ProductAndServiceWeek < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  include ProdServModule
  enum status: [ :created, :on_analysis, :finalized ]


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
      for i in 0..1
         self.service_data.new
      end
    end

      self.product_data ||= ProductData.new

      self.number ||= -1
    end
  end

  def validate_model
    errors.add(:attendance_data, 'Todos os atendimentos são obrigatórios - Semana ' + number.to_s + ';') if self.service_data[0].validate_model
    errors.add(:return_data, 'Todos os retornos são obrigatórios - Semana ' + number.to_s + ';') if self.service_data[1].validate_model
    errors.add(:product_data, 'Todos os produtos são obrigatórios;') if self.product_data.validate_model
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
