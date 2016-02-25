module ModelHelper

  # Gender: Male / Female
  # Number: Singular / Plural
  def genderize(key)
    "#{key}.#{self.model_gender}.#{self.model_number}"
  end

  def model_gender
    'm'
  end

  def model_number
    's'
  end

  def insertable
    true
  end

  def updatable
    true
  end

  def was(verb)
    I18n.t("#{verb}.#{self.model_gender}.#{self.model_number}", model: I18n.t('activerecord.models.' + self.class.model_name.param_key + '.one')).downcase.capitalize
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