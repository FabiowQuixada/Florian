class Role < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper


  # Validations
  validates :name, uniqueness: true
  validates :name, :description, :presence => true

end
