class Role < ActiveRecord::Base

  audited
  include ModelHelper

  validates :name, uniqueness: true
  validates :name, :description, :presence => true

end
