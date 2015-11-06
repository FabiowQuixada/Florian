class Role < ActiveRecord::Base

  audited

  include GenderHelper

  validates :name, uniqueness: true
  validates :name, :description, :presence => true

  def gender
    'm'
  end

  def number
    's'
  end
end
