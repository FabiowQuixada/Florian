module GenderHelper
  
  # Gender: Male / Female
  # Number: Singular / Plural  
  def genderize(key)
    "#{key}.#{self.gender}.#{self.number}" 
  end
end 