class ServiceData < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper


  # Relationships
  belongs_to :product_and_service_week


  # Validations
  validate :validate_model
  #validates :psychology, :physiotherapy, :plastic_surgery, :mesh_service, :gynecology, :occupational_therapy, :presence => true
  

  # Methods
  def validate_model
    psychology.blank? or physiotherapy.blank? or plastic_surgery.blank? or mesh_service.blank? or gynecology.blank? or occupational_therapy.blank?
  end

  def self.services
    ['psychology', 'physiotherapy', 'plastic_surgery', 'mesh_service', 'gynecology', 'occupational_therapy']
  end

  def self.number_of_services
    services.length
  end

  def qty
    sum = 0
    self.class.services.each {|service| sum += self[service]}
    sum
  end

end
