class ProductData < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper


  # Relationships
  belongs_to :product_and_service_week


  # Validations
  validate :validate_model
  #validates :mesh, :cream, :protector, :silicon, :mask, :foam, :skin_expander, :cervical_collar, :presence => true


  # Methods
  after_initialize do
    ProductData.products.each do |product|
      self.send("#{product}=", 0)
    end
  end

  def validate_model

    self.is_valid = true

    ProductData.products.each do |product|
      if send(product).nil? or send(product).blank?
        # errors.add(product, I18n.t('errors.messages.blank', attribute: I18n.t('activerecord.attributes.product_datum.' + product)))
        self.is_valid = false
        return false  
      end
    end

    true

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

  def valid?(context = nil)
    context ||= (new_record? ? :create : :update)
    output = super(context)
    errors.empty? && output && is_valid
  end


  private 
    attr_accessor :is_valid

end
