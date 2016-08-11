class SystemSetting < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper


  # RE: Receipt E-mail
  # PSE: Product and Service Email


  # Relationships
  belongs_to :user


  # Validations
  validates :pse_recipients_array, presence: { message: I18n.t('errors.system_setting.recipients') }
  validates :pse_private_recipients_array, presence: { message: I18n.t('errors.system_setting.private_recipients') }
  validates :re_title, :re_body, presence: true
  validates :pse_title, :pse_body, presence: true


  # Methods
  def model_gender
    'f'
  end

  def recipients_as_array
    return [] if pse_recipients_array.nil? || pse_recipients_array.empty?

    pse_recipients_array.split(/,/)
  end


  def private_recipients_as_array
    if pse_private_recipients_array.nil? || pse_private_recipients_array.empty?
      return []
    end

    pse_private_recipients_array.split(/,/)
  end

  def pse_processed_title(date = Date.today)
    apply_competence_tag_to user.system_setting.pse_title, date
  end

  def pse_processed_body(date = Date.today)
    apply_competence_tag_to(pse_body, date) + user.signature
  end

  def competence(date = Date.today)
    I18n.localize(date, format: :competence) unless date.nil?
  end

  def apply_competence_tag_to(text, date = Date.today)
    text.gsub(I18n.t('tags.competence'), competence(date).capitalize)
  end

  def apply_all_tags_to(text, date = Date.today)
    apply_competence_tag_to(text, date)
  end

end
