require './lib/modules/locale'

module ApplicationHelper

  include Locale

  def genderize_full_tag(model, full_tag)
    t(model.genderize(full_tag))
  end

  def model_full_path(model)
    url_for(action: 'index', controller: model.model_name.route_key, only_path: false, protocol: 'http')
  end
end
