require './lib/modules/prod_serv_module'

class ProductAndServiceWeek < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  include ProdServModule
  enum status: [ :created, :on_analysis, :finalized ]


  # Relationships
  belongs_to :product_and_service_datum
  has_one :attendance_data, :class_name => 'ServiceData'
  has_one :return_data, :class_name => 'ServiceData'
  has_one :product_data, :class_name => 'ProductData'
  accepts_nested_attributes_for :attendance_data, :return_data, :product_data


  # Validations
  validates :number, :start_date, :end_date, :presence => true
  validate :validate_model


  # Methods
  after_initialize do
    unless persisted?
      self.product_data ||= ProductData.new
      self.attendance_data ||= ServiceData.new
      self.return_data ||= ServiceData.new
    end
  end

  def validate_model
    errors.add(:attendance_data, 'Todos os atendimentos são obrigatórios;') if self.attendance_data.validate_model
    errors.add(:return_data, 'Todos os retornos são obrigatórios;') if self.return_data.validate_model
    errors.add(:product_data, 'Todos os produtos são obrigatórios;') if self.product_data.validate_model
  end

end
