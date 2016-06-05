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
  validates :recipients_array, presence: {message: I18n.t('errors.email.one_recipient')}
  validate :validate_model
  validates :value, :day_of_month, :company, :body, :presence => true


  # Methods
  def validate_model

    if !value.blank?

      if value == 0
        errors.add :value, I18n.t('errors.email.value_mandatory')
      elsif value < 0
        errors.add :value, I18n.t('errors.email.value_positive')
      elsif value > 1000000
        errors.add :value, I18n.t('errors.email.value_max')
      end
    end

    if !day_of_month.blank?
      if day_of_month < 1 or !day_of_month.is_a? Integer
        errors.add(:day_of_month, I18n.t('errors.email.month_mandatory'))
      elsif day_of_month > 28
        errors.add(:day_of_month, I18n.t('errors.email.month_max'))
      end
    end
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

  def processed_title(user, date = nil)

    if date.nil?
      date = Date.today
    end

    result = user.system_setting.re_title
    result = result.gsub(I18n.t('tags.competence'), competence(date).capitalize)
    result = result.gsub(I18n.t('tags.company'), company.name)
    result = result.gsub(I18n.t('tags.value'), ActionController::Base.helpers.number_to_currency(value) + " (" + value.real.por_extenso + ")")
    result
  end

  def processed_body(user, date = nil)

    if date.nil?
      date = Date.today
    end

    result = body
    result = result.gsub(I18n.t('tags.competence'), competence(date).capitalize)
    result = result.gsub(I18n.t('tags.company'), company.name)
    result = result.gsub(I18n.t('tags.value'), ActionController::Base.helpers.number_to_currency(value) + " (" + value.real.por_extenso + ")")
    result += user.signature
    result
  end

  def processed_receipt_text(date = nil)

    if date.nil?
      date = Date.today
    end

    if company.person?
      result = I18n.t('report.other.receipt_text.person', name: company.name, cpf: company.cpf.to_s, address: company.address, value_tag: I18n.t('tags.value'), competence_tag: I18n.t('tags.competence'))
    elsif company.company?
      result = I18n.t('report.other.receipt_text.company', name: company.registration_name, cnpj: company.cnpj.to_s, address: company.address, value_tag: I18n.t('tags.value'), competence_tag: I18n.t('tags.competence'))
    end

    result = result.gsub(I18n.t('tags.competence'), competence(date).capitalize)
    result = result.gsub(I18n.t('tags.company'), company.name)
    result = result.gsub(I18n.t('tags.value'), ActionController::Base.helpers.number_to_currency(value) + " (" + value.real.por_extenso + ")")
    result

  end

  def competence(date = nil)

    if date.nil?

      result = ''

      if current_month
        I18n.localize(Date.today, format: :competence)
      else
        I18n.localize(Date.today.next_month, format: :competence)
      end
    else
      I18n.localize(date, format: :competence)

    end
  end

  def recipients_as_array
    if recipients_array.nil? || recipients_array.empty?
      return Array.new
    end

    recipients_array.split(/,/);
  end

  def current_month
    if day_of_month > Date.today.strftime("%e").to_f
      return true
    else
      if day_of_month == Date.today.strftime("%e").to_f
        if Time.now.hour < ReceiptEmail.daily_send_hour
          return true
        end
      end
    end

    return false
  end

  def breadcrumb_path
    Hash[I18n.t('menu.emails') => '', I18n.t('menu.email.receipt') => '']
  end

end
