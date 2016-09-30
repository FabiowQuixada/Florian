require 'date'

class ReceiptEmail < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  usar_como_dinheiro :value
  after_initialize :init


  # Constants
  DAILY_SEND_HOUR = 7
  RECENT_EMAILS_DAYS = 7


  # Relationships
  has_many :email_histories, dependent: :destroy
  accepts_nested_attributes_for :email_histories
  belongs_to :company
  alias_attribute :history, :email_histories


  # Validations
  validates :recipients_array, presence: { message: I18n.t('errors.email.one_recipient') }
  validates_numericality_of :value, greater_than: 0, less_than_or_equal_to: 1_000_000
  validates_numericality_of :day_of_month, greater_than: 0, less_than_or_equal_to: 28
  validates :value, :day_of_month, :company, :body, presence: true


  # Methods
  def to_s
    company.name
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

  def breadcrumb_path
    Hash[I18n.t('menu.emails') => '', I18n.t('menu.email.receipt') => '']
  end

  private ###############################################################################################################

  def receipt_text
    return pf_text if company.person?
    return pj_text if company.company?
  end

  def pf_text
    EnvironmentContentHandler.receipt_report_pf_main_text company
  end

  def pj_text
    EnvironmentContentHandler.receipt_report_pj_main_text company
  end

  def apply_competence_tag_to(text, date)
    text.gsub(I18n.t('tags.competence'), competence(date).capitalize)
  end

  def apply_company_tag_to(text)
    text.gsub(I18n.t('tags.company'), company.name)
  end

  def apply_value_tag_to(text)
    text.gsub(I18n.t('tags.value'), "#{ActionController::Base.helpers.number_to_currency(value)} (#{value.real.por_extenso})")
  end

  def apply_all_tags_to(text, date = Date.today)
    apply_value_tag_to apply_company_tag_to apply_competence_tag_to(text, date)
  end
end
