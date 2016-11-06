module ModelHelper

  # Gender: (M)ale / (F)emale
  # Number: (S)ingular / (P)lural
  def genderize(key)
    "#{key}.#{model_gender}.#{model_number}"
  end

  def model_gender
    I18n.t "activerecord.gender.#{self.class.model_name.name.underscore}"
  end

  def model_number
    I18n.t "activerecord.number.#{self.class.model_name.name.underscore}"
  end

  def was(verb)
    I18n.t("model_phrases.past_actions.#{verb}.#{model_gender}.#{model_number}", model: I18n.t("activerecord.models.#{self.class.model_name.param_key}.one")).downcase.capitalize
  end

  def breadcrumb_path
    Hash[model_name.human(count: 2) => 'send(self.model_name.route_key + "_path")']
  end

  def blank_error_message(field)
    attribute = I18n.t("activerecord.attributes.#{self.class.name.underscore}.#{field}")
    I18n.t('errors.messages.blank', attribute: attribute)
  end

  def monetize(att, val)
    self[att] = if val.nil?
                  nil
                else
                  val.to_s.scan(/\b-?[\d.]+/).join.to_f
                end
  end
end
