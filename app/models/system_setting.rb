class SystemSetting < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper

  # RE: Receipt E-mail
  # PSE: Product and Service Email

  belongs_to :user

  validates :re_title, :re_body, :presence => true
  validates :pse_title, :pse_day_of_month, :pse_body, :presence => true

  def gender
    'f'
  end

    def recipients_as_array
    if pse_recipients_array.nil? || pse_recipients_array.empty?
      return Array.new
    end

    pse_recipients_array.split(/,/);
  end

end
