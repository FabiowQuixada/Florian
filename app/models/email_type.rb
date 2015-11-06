class EmailType < ActiveRecord::Base
  
  # Validations
  validates :name, :email_title, :presence => true
end
