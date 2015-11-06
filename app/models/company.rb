class Company < ActiveRecord::Base

  audited

  include GenderHelper

  has_many :email

  validates :simple_name, :long_name, uniqueness: true
  validates :simple_name, :long_name, :presence => true

  def gender
    'f'
  end

  def number
    's'
  end
end
