require 'date'

class ReceiptEmail < ActiveRecord::Base

  # Configuration
  audited
  include ModelHelper
  usar_como_dinheiro :value


  # Relationships
  has_many :email_histories
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

  def self.daily_send_hour
    7
  end

  def self.recent_emails_days
    7
  end

  def title(user)
    user.system_setting.re_title
  end

  def processed_title(user, date = Date.today)
    apply_all_tags_to user.system_setting.re_title, date
  end

  def processed_body(user, date = Date.today)
    apply_all_tags_to(body, date) + user.signature
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

  def current_month?

    return true if day_of_month > Date.today.strftime('%e').to_f
    return true if Time.now.hour < ReceiptEmail.daily_send_hour && day_of_month == Date.today.strftime('%e').to_f

    false
  end

  def breadcrumb_path
    Hash[I18n.t('menu.emails') => '', I18n.t('menu.email.receipt') => '']
  end

  private

  def receipt_text
    return pf_text if company.person?
    return pj_text if company.company?
  end

  def pf_text
    I18n.t('report.other.receipt_text.person', name: company.name, cpf: company.cpf.to_s, address: company.address, value_tag: I18n.t('tags.value'), competence_tag: I18n.t('tags.competence'))
  end

  def pj_text
    I18n.t('report.other.receipt_text.company', name: company.registration_name, cnpj: company.cnpj.to_s, address: company.address, value_tag: I18n.t('tags.value'), competence_tag: I18n.t('tags.competence'))
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
    return errors.add :value, I18n.t('errors.email.value_mandatory') if value == 0
    return errors.add :value, I18n.t('errors.email.value_positive') if value < 0
    return errors.add :value, I18n.t('errors.email.value_max') if value > 1_000_000
  end
  # rubocop:enable all

  def validate_day_of_month

    return if day_of_month.blank?

    errors.add(:day_of_month, I18n.t('errors.email.month_mandatory')) if day_of_month < 1
    errors.add(:day_of_month, I18n.t('errors.email.month_max')) if day_of_month > 28
  end
end
