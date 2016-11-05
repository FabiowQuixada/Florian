class EnvironmentContentHandler

  def self.logo_path
    return "#{Rails.root}/app/assets/images/app_logo.png" if Rails.env == 'showcase'
    "#{Rails.root}/app/assets/images/logo_text.jpg"
  end

  def self.report_footer(pdf)
    if Rails.env == 'showcase'
      pdf.text I18n.t('showcase.report.footer.address'), size: 10, align: :center
      pdf.text I18n.t('showcase.report.footer.phone'), size: 10, align: :center
      pdf.text I18n.t('showcase.report.footer.email'), size: 10, align: :center
    else
      pdf.text I18n.t('report.footer.address'), size: 10, align: :center
      pdf.text I18n.t('report.footer.phone'), size: 10, align: :center
      pdf.text I18n.t('report.footer.email'), size: 10, align: :center
    end
  end

  def self.render_president_signature(pdf)
    signature_path, president_name, president_signature = president_data

    pdf.move_down 30
    pdf.image signature_path, scale: 0.15, position: :center
    pdf.move_up 15 if Rails.env != 'showcase'
    pdf.text president_name, inline_format: true, style: :bold, align: :center
    pdf.text president_signature, inline_format: true, style: :bold, align: :center
  end

  def self.receipt_report_person_main_text(maintainer)
    I18n.t(person_tag,
           name: maintainer.name,
           cpf: maintainer.cpf.to_s,
           address: maintainer.address,
           value_tag: I18n.t('tags.value'),
           competence_tag: I18n.t('tags.competence'))
  end

  def self.receipt_report_company_main_text(maintainer)
    I18n.t(company_tag,
           name: maintainer.registration_name,
           cnpj: maintainer.cnpj.to_s,
           address: maintainer.address,
           value_tag: I18n.t('tags.value'),
           competence_tag: I18n.t('tags.competence'))
  end

  def self.person_tag
    if Rails.env == 'showcase'
      'showcase.report.person_receipt_text'
    else
      'report.other.receipt_text.person'
    end
  end

  def self.company_tag
    if Rails.env == 'showcase'
      'showcase.report.company_receipt_text'
    else
      'report.other.receipt_text.maintainer'
    end
  end

  def self.president_data
    if Rails.env == 'showcase'
      signature_path = "#{Rails.root}/app/assets/images/showcase_president_signature.png"
      president_name = I18n.t('showcase.report.president_name')
      president_signature = I18n.t('showcase.report.president_description')
    else
      signature_path = "#{Rails.root}/app/assets/images/president_signature.png"
      president_name = I18n.t('report.president_name')
      president_signature = I18n.t('report.president_description')
    end

    [signature_path, president_name, president_signature]
  end

end
