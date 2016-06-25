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

  def pse_processed_title(date = Date.today)
    apply_competence_tag_to user.system_setting.pse_title, date
  end

  def pse_processed_body(date = Date.today)
    apply_competence_tag_to(pse_body, date) + user.signature
  end

  def pse_processed_receipt_text(date = Date.today)
    apply_all_tags_to receipt_text, date
  end

  def competence(date = nil)

    I18n.localize(date, format: :competence) unless date.nil?
  end

  def receipt_text
    pf_text if company.person?
    pj_text if company.company?
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

end
