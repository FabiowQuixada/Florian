class ProdServMailer < ApplicationMailer

  def send_weekly_email(week, user)

    attach_report week

    period = week_period week

    mail(to: user.system_setting.pse_private_recipients_array,
         subject: SSETTINGS_PSE_TITLE_PREFIX + period,
         body: SSETTINGS_PSE_BODY_WEEK.gsub(I18n.t('tags.competence'), period) + user.signature)
  end

  def send_to_analysis(week, user)

    attach_report week

    mail(to: ANALYSIS_EMAIL,
         body: user.system_setting.pse_processed_body(week.product_and_service_datum.competence),
         subject: user.system_setting.pse_processed_title(week.product_and_service_datum.competence))
  end

  def send_monthly_email(week, user)

    attach_report week

    mail(to: user.system_setting.pse_recipients_array,
         body: user.system_setting.pse_processed_body(week.product_and_service_datum.competence),
         subject: user.system_setting.pse_processed_title(week.product_and_service_datum.competence))
  end

  private

  def attach_report(week)
    ProductAndServiceReport.new(file_name, week).save
    attachments[attachment_name(week)] = File.read(file_name)
    File.delete(file_name)
  end

  def attachment_name(week)
    date = week.product_and_service_datum.competence
    'relatorio_de_produtos_e_servicos_' + l(date, format: '%B').downcase + '_' + date.year.to_s + '.pdf'
  end

  def week_period(week)
    week.start_date.to_s + ' ' + I18n.t('helpers.to') + ' ' + week.end_date.to_s
  end

end
