class Role < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper

  # Relationships
  has_many :users

  # Validations
  validates :name, uniqueness: true
  validates :name, :description, :presence => true

end
