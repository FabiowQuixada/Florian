class EmailConfiguration < ActiveRecord::Base

  audited

  include GenderHelper

  validates :signature, :test_recipient, :bcc, :presence => true

  def active?
    true
  end

  def active
    true
  end

  def gender
    'f'
  end

  def number
    'p'
  end

end
