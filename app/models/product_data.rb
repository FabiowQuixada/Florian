class ProductData < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper


  # Relationships
  belongs_to :product_and_service_week


  # Validations
  validate :validate_model
  #validates :mesh, :cream, :protector, :silicon, :mask, :foam, :skin_expander, :cervical_collar, :presence => "true"


  # Methods
  def validate_model
    mesh.blank? or cream.blank? or protector.blank? or silicon.blank? or mask.blank? or foam.blank? or skin_expander.blank? or cervical_collar.blank?
  end

  def self.products
    ['mesh', 'cream', 'protector', 'silicon', 'mask', 'foam', 'skin_expander', 'cervical_collar']
  end

  def self.number_of_products
    products.length
  end

  def qty
    sum = 0
    self.class.products.each {|product| sum += (self[product] ? self[product] : 0)}
    sum
  end

end
