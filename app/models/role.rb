class Role < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper

  # Relationships
  has_many :users, dependent: :restrict_with_error

  # Validations
  validates :name, uniqueness: true
  validates :name, :description, presence: true

  # Methods
  def to_s
    name
  end
end
