require './lib/modules/locale'

module ApplicationHelper

  # TODO Verificar utilidade de todos os métodos

  include Locale

  def genderize_full_tag(model, full_tag)
    t(model.genderize(full_tag))
  end

end
