module Locale

  def genderize_tag(model, tag)
    I18n.t(model.genderize(tag), model: t('activerecord.models.' + model.class.model_name.param_key + '.one')).downcase.capitalize
  end

  def genderize_full_tag(model, full_tag)
    I18n.t(model.genderize(full_tag))
  end

end
