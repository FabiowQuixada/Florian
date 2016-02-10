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
  validates :competence,  :presence => true


  # Methods
  # def breadcrumb_path
  #   Hash[I18n.t('menu.XXX') => '', I18n.t('menu.XXX.YYY') => '']
  # end
  def gender 
    'f'
  end

  def default_values
    self.competence ||= Date.today
  end

end
