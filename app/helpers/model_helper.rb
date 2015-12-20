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

  def visualizable
    false
  end
end