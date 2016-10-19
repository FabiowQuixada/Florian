require 'rails_helper'

describe ProdServMailer, type: :mailer do
  let(:week) { create :product_and_service_week }
  let(:user) { build :user, :common }

  describe 'weekly e-mail' do
    let(:period) { week.period }
    let(:mail) { described_class.send_weekly_email(week, user).deliver_now }
    let(:competence) { week.product_and_service_datum.competence }

    it_behaves_like 'a psd e-mail'
    it { expect(mail.to).to eq(user.system_setting.private_recipients_as_array) }
    it { expect(mail.subject).to eq(I18n.t('defaults.report.product_and_service.email_title').gsub(I18n.t('tags.competence'), period)) }
    it { expect(body_text(mail)).to eq(I18n.t('defaults.report.product_and_service.weekly_email_body').gsub(I18n.t('tags.competence'), period) + user.full_signature) }
  end


  describe 'analysis e-mail' do
    let(:competence) { week.product_and_service_datum.competence }
    let(:mail) { described_class.send_to_analysis(week, user).deliver_now }

    it_behaves_like 'a psd e-mail'
    it { expect(mail.to).to eq([ANALYSIS_EMAIL]) }
    it { expect(mail.subject).to eq(user.system_setting.pse_processed_title(competence)) }
    it { expect(body_text(mail)).to eq(user.system_setting.pse_processed_body(competence)) }
  end

  describe 'maintainers e-mail' do
    let(:competence) { week.product_and_service_datum.competence }
    let(:mail) { described_class.send_monthly_email(week, user).deliver_now }

    it_behaves_like 'a psd e-mail'
    it { expect(mail.to).to eq(user.system_setting.recipients_as_array) }
    it { expect(mail.subject).to eq(user.system_setting.pse_processed_title(competence)) }
    it { expect(body_text(mail)).to eq(user.system_setting.pse_processed_body(competence)) }
  end

  def get_message_part(mail, content_type)
    mail.body.parts.find { |p| p.content_type.match content_type }.body.raw_source
  end
end
