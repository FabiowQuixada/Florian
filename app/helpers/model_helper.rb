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

  def updatable
    true
  end
end