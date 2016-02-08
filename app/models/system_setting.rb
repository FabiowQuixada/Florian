class SystemSetting < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper


  # RE: Receipt E-mail
  # PSE: Product and Service Email


  # Relationships
  belongs_to :user


  # Validations
  validates :pse_recipients_array, presence: {message: I18n.t('errors.system_setting.recipients')}
  validates :pse_private_recipients_array, presence: {message: I18n.t('errors.system_setting.private_recipients')}
  validates :re_title, :re_body, :presence => true
  validates :pse_title, :pse_day_of_month, :pse_body, :presence => true


  # Methods
  def gender
    'f'
  end

  def recipients_as_array
    if pse_recipients_array.nil? || pse_recipients_array.empty?
      return Array.new
    end

    pse_recipients_array.split(/,/);
  end

  
  def private_recipients_as_array
    if pse_private_recipients_array.nil? || pse_private_recipients_array.empty?
      return Array.new
    end

    pse_private_recipients_array.split(/,/);
  end

end
