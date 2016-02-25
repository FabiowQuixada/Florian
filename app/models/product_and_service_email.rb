require './lib/modules/prod_serv_module'

class ProductAndServiceEmail < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  include ProdServModule
  enum status: [ :created, :on_analysis, :finalized ]


  # Relationships
  has_many :product_and_service_data


  # Validations
  validate :validate_model
  validates :competence_date, :presence => true
  validates :psychology, :physiotherapy, :plastic_surgery, :mesh_service, :gynecology, :occupational_therapy, :presence => true
  validates :mesh, :cream, :protector, :silicon, :mask, :foam, :skin_expander, :cervical_collar, :presence => "true"


  # Methods
  after_initialize do
    # if self.product_and_service_data.empty?
    #   for i in 0..2
    #      self.product_and_service_data.new
    #   end
    # end
  end

  def validate_model

  # if psychology.blank? or physiotherapy.blank? or plastic_surgery.blank? or mesh_service.blank? or gynecology.blank? or occupational_therapy.blank? or psychology_return.blank? or physiotherapy_return.blank? or plastic_surgery_return.blank? or mesh_service_return.blank? or gynecology_return.blank? or occupational_therapy_return.blank?
  #     errors.add(:cream, 'Todos os serviços são obrigatórios;')
  # end

  #   if mesh.blank? or cream.blank? or protector.blank? or silicon.blank? or mask.blank? or foam.blank? or skin_expander.blank? or cervical_collar
  #     errors.add(:cream, 'Todos os produtos são obrigatórios;')
  #   end
  end

  def self.services
    ['psychology', 'physiotherapy', 'plastic_surgery', 'mesh_service', 'gynecology', 'occupational_therapy']
  end

  def self.products
    ['mesh', 'cream', 'protector', 'silicon', 'mask', 'foam', 'skin_expander', 'cervical_collar']
  end

  def services_qty
    psychology + physiotherapy + plastic_surgery + mesh_service + gynecology + occupational_therapy + psychology_return + physiotherapy_return + plastic_surgery_return + mesh_service_return + gynecology_return + occupational_therapy_return
  end

  def products_qty
    mesh + cream + protector + silicon + mask + foam + skin_expander + cervical_collar
  end

  def processed_title(user, date = nil)

    if date.nil?
      date = competence_date.to_date
    end

    result = user.system_setting.pse_title
    result = result.gsub(I18n.t('tags.competence'), competence(date).capitalize)
    result
  end

  def processed_body(user, date = nil)

    if date.nil?
      date = competence_date.to_date
    end

    result = user.system_setting.pse_body
    result = result.gsub(I18n.t('tags.competence'), competence(date).capitalize)
    result += " \n \n-- \n" + user.signature
    result
  end

  def competence(date = nil)

    if date.nil?
      date = competence_date.to_date
    end

      I18n.localize(date, format: :competence)
  end

  def recipients_as_array
    if recipients_array.nil? || recipients_array.empty?
      return Array.new
    end

    recipients_array.split(/,/);
  end

  def visualizable
    true
  end

  def can_edit?
    !finalized?
  end

  def status_desc
    I18n.t('activerecord.enums.product_and_service_datum.status.' + status)
  end

  def breadcrumb_path
    Hash[I18n.t('menu.emails') => '', I18n.t('menu.email.prod_serv') => '']
  end

end
