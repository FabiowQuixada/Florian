class ProductAndServiceDatum < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  enum status: [ :created, :on_analysis, :finalized ]


  # Relationships
  has_many :product_and_service_weeks, -> { order("number") }, :dependent => :destroy
  alias_attribute :weeks, :product_and_service_weeks
  accepts_nested_attributes_for :product_and_service_weeks
  

  # Validations
  validates :status, :competence, :presence => true
  validates :competence, uniqueness: true
  

  # Methods
  after_initialize do
    if self.product_and_service_weeks.empty?
      for i in 1..NUMBER_OF_WEEKS
         self.product_and_service_weeks.new :number => i
      end
    end

    self.competence ||= Date.today
  end


  def can_edit?
    !finalized?
  end

  def status_desc
    I18n.t('activerecord.enums.product_and_service_datum.status.' + status.to_s)
  end

end
