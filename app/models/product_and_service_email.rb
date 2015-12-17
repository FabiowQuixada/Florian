require 'date'

class ProductAndServiceEmail < ActiveRecord::Base

  audited
  include ModelHelper
  # after_initialize :default_values

  SERVICES = ['psychology', 'physiotherapy', 'plastic_surgery', 'mesh_service', 'gynecology', 'occupational_therapy']
  PRODUCTS = ['mesh', 'cream', 'protector', 'silicon', 'mask', 'foam', 'skin_expander', 'cervical_collar']


  # Validations
  validate :validate_model
  validates :competence_date, :presence => true
  validates :psychology, :physiotherapy, :plastic_surgery, :mesh_service, :gynecology, :occupational_therapy, :presence => true
  validates :mesh, :cream, :protector, :silicon, :mask, :foam, :skin_expander, :cervical_collar, :presence => "true"


  # Methods
  def validate_model

  #   if psychology.blank? or physiotherapy.blank? or plastic_surgery.blank? or mesh_service.blank? or gynecology.blank? or occupational_therapy.blank? or psychology_return.blank? or physiotherapy_return.blank? or plastic_surgery_return.blank? or mesh_service_return.blank? or gynecology_return.blank? or occupational_therapy_return.blank?
  #     errors.add(:cream, 'Todos os serviços são obrigatórios;')
  # end

  #   if mesh.blank? or cream.blank? or protector.blank? or silicon.blank? or mask.blank? or foam.blank? or skin_expander.blank? or cervical_collar
  #     errors.add(:cream, 'Todos os produtos são obrigatórios;')
  #   end
  end

  def services
    psychology + physiotherapy + plastic_surgery + mesh_service + gynecology + occupational_therapy + psychology_return + physiotherapy_return + plastic_surgery_return + mesh_service_return + gynecology_return + occupational_therapy_return
  end

  def products
    mesh + cream + protector + silicon + mask + foam + skin_expander + cervical_collar
  end

  def title
    'Relatório Mensal IAQ - ' + I18n.t('tags.competence')
  end

  def processed_title(date = nil)

    if date.nil?
      date = Date.today
    end

    result = title

    result = result.gsub(I18n.t('tags.competence'), capital_competence(date))
    result = result.gsub(I18n.t('tags.company'), company.trading_name)
    result
  end

  # def processed_body(date = nil)

  #   if date.nil?
  #     date = Date.today
  #   end

  #   result = body
  #   result = result.gsub(I18n.t('tags.competence'), capital_competence(date))
  #   result = result.gsub(I18n.t('tags.company'), company.trading_name)
  #   result = result.gsub(I18n.t('tags.value'), ActionController::Base.helpers.number_to_currency(value) + " (" + value.real.por_extenso + ")")
  # end

  def competence
      I18n.localize(competence_date.to_date, format: :competence)
  end


  def recipients_as_array
    if recipients_array.nil? || recipients_array.empty?
      return Array.new
    end

    recipients_array.split(/,/);
  end

  def updatable
    false
  end

  def visualizable
    true
  end

end
