class ServiceData < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  enum service_type: [:attendance, :return]


  # Relationships
  belongs_to :product_and_service_week


  # Validations
  validate :validate_model
  validates :service_type, presence: true
  validates :service_type, inclusion: { in: service_types.keys }, allow_nil: true
  validates :psychology, :physiotherapy, :plastic_surgery, :mesh, :gynecology, :occupational_therapy, presence: true


  # Methods
  after_initialize do
    unless persisted?
      ServiceData.services.each do |service|
        send("#{service}=", 0) if send(service).nil?
      end
    end
  end

  def validate_model
    self.is_valid = true

    ServiceData.services.each do |service|
      next unless send(service).nil? || send(service).blank?
      # errors.add(service, I18n.t('errors.messages.blank', attribute: I18n.t("activerecord.attributes.service_datum.#{service}")))
      self.is_valid = false
      return false
    end

    true
  end

  def self.services
    %w(psychology physiotherapy plastic_surgery mesh gynecology occupational_therapy)
  end

  def self.number_of_services
    services.length
  end

  def qty
    sum = 0
    self.class.services.each { |service| sum += (self[service] ? self[service] : 0) }
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
