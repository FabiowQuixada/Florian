require './lib/modules/locale'

module ApplicationHelper

  include Locale

  def genderize_full_tag(model, full_tag)
    t(model.genderize(full_tag))
  end

end
