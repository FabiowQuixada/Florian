class Bill < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  usar_como_dinheiro :water
	usar_como_dinheiro :energy
	usar_como_dinheiro :telephone
	after_initialize :default_values


  # Relationships



  # Validations
  validates :competence, :presence => true, uniqueness: true
  validates :water, :energy, :telephone, :numericality => { :greater_than_or_equal_to => 0 }
  validate :validate_model


  # Methods
  # def breadcrumb_path
  #   Hash[I18n.t('menu.XXX') => '', I18n.t('menu.XXX.YYY') => '']
  # end
  def model_gender 
    'f'
  end

  private
  def default_values
    self.competence ||= Date.today
  end

  def validate_model
    byebug
    self.competence = self.competence.change(:day => 1)
  end

end
