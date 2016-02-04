module ModelHelper

  # Gender: Male / Female
  # Number: Singular / Plural
  def genderize(key)
    "#{key}.#{self.gender}.#{self.number}"
  end

  def gender
    'm'
  end

  def number
    's'
  end

  def insertable
    true
  end

  def updatable
    true
  end

  def was(verb)
    I18n.t("#{verb}.#{self.gender}.#{self.number}", model: I18n.t('activerecord.models.' + self.class.model_name.param_key + '.one')).downcase.capitalize
  end

  def visualizable
    false
  end

  def breadcrumb_path
    Hash[self.model_name.human(:count => 2) => 'send(self.model_name.route_key + "_path")']
  end

  def breadcrumb_suffix
  end
end