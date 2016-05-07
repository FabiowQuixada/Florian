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
      for i in 1..NUMBER_OF_WEEKS+2
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

  def service_qty
    sum = 0

    weeks.each {|week| sum += week.service_qty if week.number <= 5 }
    
    sum
  end

  def product_qty
    sum = 0

    weeks.each {|week| sum += week.product_qty if week.number <= 5 }
    
    sum
  end

  def model_number
    'p'
  end

  def final_week
    weeks.last
  end

end
