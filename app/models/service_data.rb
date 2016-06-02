class ServiceData < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper


  # Relationships
  belongs_to :product_and_service_week


  # Validations
  validate :validate_model
  #validates :service_type, presence: true
  #validates :psychology, :physiotherapy, :plastic_surgery, :mesh, :gynecology, :occupational_therapy, :presence => true  


  # Methods
  after_initialize do
    ServiceData.services.each do |service|
      self.send("#{service}=", 0)
    end
  end

  def validate_model

    self.is_valid = true

    ServiceData.services.each do |service|
      if send(service).nil? or send(service).blank?
        # errors.add(service, I18n.t('errors.messages.blank', attribute: I18n.t('activerecord.attributes.service_datum.' + service)))
        self.is_valid = false
        return false
      end
    end

    if self.service_type.nil? or self.service_type.blank?
      # errors.add(:service_type, I18n.t('errors.messages.blank', attribute: I18n.t('activerecord.attributes.service_datum.service_type')))
      self.is_valid = false
      return false
    end

    true

  end

  def self.services
    ['psychology', 'physiotherapy', 'plastic_surgery', 'mesh', 'gynecology', 'occupational_therapy']
  end

  def self.number_of_services
    services.length
  end

  def qty
    sum = 0
    self.class.services.each {|service| sum += (self[service] ? self[service] : 0)}
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
