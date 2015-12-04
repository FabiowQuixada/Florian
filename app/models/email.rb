require 'date'

class Email < ActiveRecord::Base

  audited
  include ModelHelper
  usar_como_dinheiro :value


  # Relationships
  has_many :email_histories
  accepts_nested_attributes_for :email_histories
  belongs_to :company
  #belongs_to :type, :class_name => 'EmailType', :foreign_key => 'email_type_id'
  alias_attribute :history, :email_histories
  #alias_attribute :type, :email_type_id


  # Validations
  validates :recipients_array, presence: {message: I18n.t('errors.email.one_recipient')}
  validate :validate_model
  validates :company, uniqueness: true
  validates :value, :day_of_month, :company, :body, :presence => true
  #:type


  # Methods
  def validate_model

    if !value.blank?

      if value == 0
        errors.add(:value, I18n.t('errors.email.value_mandatory'))
      elsif value < 0
        errors.add(:value, I18n.t('errors.email.value_positive'))
      elsif value > 1000000
        errors.add(:value, I18n.t('errors.email.value_max'))
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

  def title

    #return type.email_title unless type.nil?

    'Recibo de Doação IAQ ' + I18n.t('tags.company') + ' - ' + I18n.t('tags.competence')
  end

  def processed_title(date = nil)

    if date.nil?
      date = Date.today
    end

    result = title

    result = result.gsub(I18n.t('tags.competence'), capital_competence(date))
    result = result.gsub(I18n.t('tags.company'), company.trading_name)
    result
  end

  def processed_body(date = nil)

    if date.nil?
      date = Date.today
    end

    result = body
    result = result.gsub(I18n.t('tags.competence'), capital_competence(date))
    result = result.gsub(I18n.t('tags.company'), company.trading_name)
    result = result.gsub(I18n.t('tags.value'), ActionController::Base.helpers.number_to_currency(value) + " (" + value.real.por_extenso + ")")
  end

  def processed_pdf_text(date = nil)

    if date.nil?
      date = Date.today
    end

    'A ONG – Instituto de Apoio ao Queimado (IAQ), inscrita sob o CNPJ/MF nº 08.093.224/0001-05, situada à Rua Visconde de Sabóia, nº 75, salas 01 a 16 – Centro, recebeu da ' + company.name + ', inscrito sob o CNPJ/MF nº ' + company.cnpj.to_s + ', situada na ' + company.address + ', a importância supra de ' + I18n.t('tags.value') + ' como doação em ' + I18n.t('tags.competence') + '.'
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

  def capital_competence(date = nil)
    competence(date).capitalize
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
        if Time.now.hour < 7#self.daily_send_hour
          return true
        end
      end
    end

    return false
  end

end
