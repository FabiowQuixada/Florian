class ProdServMailer < ApplicationMailer

  def send_weekly_email(week, user)
    attach_report week

    mail(to: user.system_setting.pse_private_recipients_array,
         subject: SETTINGS_PSE_TITLE_PREFIX + week.period,
         body: SETTINGS_PSE_BODY_WEEK.gsub(I18n.t('tags.competence'), week.period) + user.full_signature)
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
    prefix = I18n.t('report.attachment.prod_serv_report')
    date = week.product_and_service_datum.competence
    month = l(date, format: '%B').downcase
    "#{prefix}_#{month}_#{date.year}.pdf"
  end
end
