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
  validates :pse_title, :pse_day_of_month, :pse_body, presence: true


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

  def pse_processed_title(date = nil)

    date = Date.today if date.nil?

    result = user.system_setting.pse_title
    result = result.gsub(I18n.t('tags.competence'), competence(date).capitalize)
    result
  end

  def pse_processed_body(date = nil)

    date = Date.today if date.nil?

    result = pse_body
    result = result.gsub(I18n.t('tags.competence'), competence(date).capitalize)
    result += user.signature
    result
  end

  def pse_processed_receipt_text(date = nil)

    date = Date.today if date.nil?

    if company.person?
      result = I18n.t('report.other.receipt_text.person', name: company.name, cpf: company.cpf.to_s, address: company.address, value_tag: I18n.t('tags.value'), competence_tag: I18n.t('tags.competence'))
    elsif company.company?
      result = I18n.t('report.other.receipt_text.company', name: company.registration_name, cnpj: company.cnpj.to_s, address: company.address, value_tag: I18n.t('tags.value'), competence_tag: I18n.t('tags.competence'))
    end

    result = result.gsub(I18n.t('tags.competence'), competence(date).capitalize)
    result = result.gsub(I18n.t('tags.company'), company.name)
    result = result.gsub(I18n.t('tags.value'), ActionController::Base.helpers.number_to_currency(value) + ' (' + value.real.por_extenso + ')')
    result

  end

  def competence(date = nil)

    I18n.localize(date, format: :competence) unless date.nil?
  end

end
