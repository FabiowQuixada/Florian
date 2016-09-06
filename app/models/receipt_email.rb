require 'date'

class ReceiptEmail < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  usar_como_dinheiro :value


  DAILY_SEND_HOUR = 7
  RECENT_EMAILS_DAYS = 7


  # Relationships
  has_many :email_histories, dependent: :destroy
  accepts_nested_attributes_for :email_histories
  belongs_to :company
  alias_attribute :history, :email_histories


  # Validations
  validates :recipients_array, presence: { message: I18n.t('errors.email.one_recipient') }
  validate :validate_model
  validates :value, :day_of_month, :company, :body, presence: true


  # Methods
  def validate_model
    validate_value && validate_day_of_month
  end

  def alias
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

    if current_month?
      I18n.localize(Date.today, format: :competence)
    else
      I18n.localize(Date.today.next_month, format: :competence)
    end
  end

  def recipients_as_array
    return [] if recipients_array.nil? || recipients_array.empty?
    recipients_array.split(/,/)
  end

  def breadcrumb_path
    Hash[I18n.t('menu.emails') => '', I18n.t('menu.email.receipt') => '']
  end

  # Query methods
  def self.all_by_delivery_date
    this_month_emails, next_month_emails = receipts_by_month
    receipts_by_day this_month_emails, next_month_emails
  end

  def self.receipts_by_month
    this_month_emails = []
    next_month_emails = []

    all.each do |email|
      if email.current_month?
        this_month_emails << email
      else
        next_month_emails << email
      end
    end

    [this_month_emails, next_month_emails]
  end

  def self.receipts_by_day(this_month_emails, next_month_emails)
    this_month_emails.sort! { |a, b| a.day_of_month <=> b.day_of_month }
    next_month_emails.sort! { |a, b| a.day_of_month <=> b.day_of_month }

    next_month_emails = next_month_emails.sort_by do |item|
      item[:day_of_month]
    end

    this_month_emails + next_month_emails
  end

  def current_month?
    return true if day_of_month > Date.today.strftime('%e').to_f
    return true if Time.now.hour < DAILY_SEND_HOUR && day_of_month == Date.today.strftime('%e').to_f

    false
  end


  private ###############################################################################################################

  private_class_method :receipts_by_month
  private_class_method :receipts_by_day

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
    text.gsub(I18n.t('tags.value'), ActionController::Base.helpers.number_to_currency(value) + ' (' + value.real.por_extenso + ')')
  end

  def apply_all_tags_to(text, date = Date.today)
    apply_value_tag_to apply_company_tag_to apply_competence_tag_to(text, date)
  end

  # rubocop:disable all
  def validate_value
    return if value.blank?
    return errors.add :value, blank_error_message('value') if value == 0
    return errors.add :value, I18n.t('errors.email.value_positive') if value < 0
    return errors.add :value, I18n.t('errors.email.value_max') if value > 1_000_000
  end
  # rubocop:enable all

  def validate_day_of_month
    return if day_of_month.blank?
    return errors.add(:day_of_month, blank_error_message('day_of_month')) if day_of_month < 1
    return errors.add(:day_of_month, I18n.t('errors.email.month_max')) if day_of_month > 28
  end
end
