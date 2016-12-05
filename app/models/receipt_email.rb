class ReceiptEmail < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  after_initialize :init


  # Constants
  DAILY_SEND_HOUR = 7
  RECENT_EMAILS_DAYS = 7


  # Relationships
  has_many :email_histories, dependent: :destroy
  accepts_nested_attributes_for :email_histories
  belongs_to :maintainer
  alias_attribute :history, :email_histories


  # Validations
  validates :recipients_array, presence: { message: I18n.t('errors.email.one_recipient') }
  validates_numericality_of :value, greater_than: 0, less_than_or_equal_to: 1_000_000
  validates_numericality_of :day_of_month, greater_than: 0, less_than_or_equal_to: 28
  validates :value, :day_of_month, :maintainer, :body, presence: true


  # Methods
  def value=(val)
    monetize :value, val
  end

  def to_s
    maintainer.name
  end

  def title(user)
    user.system_setting.re_title
  end

  def processed_title(user, date = Date.today)
    apply_all_tags_to user.system_setting.re_title, date
  end

  def processed_body(user, date = Date.today)
    apply_all_tags_to(body, date) + user.full_signature
  end

  def processed_receipt_text(date = Date.today)
    apply_all_tags_to receipt_text, date
  end

  def competence(date = nil)
    return I18n.localize(date, format: :competence) unless date.nil?
    I18n.localize(Date.today, format: :competence)
  end

  def init
    self.day_of_month = 1
  end

  def recipients_as_array
    return [] if recipients_array.nil? || recipients_array.empty?
    recipients_array.split(/,/)
  end

  private ###############################################################################################################

  def receipt_text
    return person_text if maintainer.person?
    return company_text if maintainer.company?
  end

  def person_text
    EnvironmentContentHandler.receipt_report_person_main_text maintainer
  end

  def company_text
    EnvironmentContentHandler.receipt_report_company_main_text maintainer
  end

  def apply_competence_tag_to(text, date)
    text.gsub(I18n.t('tags.competence'), competence(date).capitalize)
  end

  def apply_maintainer_tag_to(text)
    text.gsub(I18n.t('tags.maintainer'), maintainer.name)
  end

  def apply_value_tag_to(text)
    text.gsub(I18n.t('tags.value'), LocaleHandler.full_money_desc(value))
  end

  def apply_all_tags_to(text, date = Date.today)
    apply_value_tag_to apply_maintainer_tag_to apply_competence_tag_to(text, date)
  end
end
