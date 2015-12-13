class Contact < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper

  validates :telephone, length: { is: 14 }, :allow_blank => true
  validates :celphone, length: { in: 14..16 }, :allow_blank => true
end
