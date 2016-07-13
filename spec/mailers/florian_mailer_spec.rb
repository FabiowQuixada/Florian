require 'rails_helper'

describe FlorianMailer, type: :mailer do
  let(:week) { create :product_and_service_week }
  let(:user) { build :user, :common }

  describe 'weekly e-mail' do
    let(:period) { week.start_date.to_s + ' ' + I18n.t('helpers.to') + ' ' + week.end_date.to_s }
    let(:mail) { described_class.send_weekly_prod_and_serv_email(week, user).deliver_now }

    it_behaves_like 'an psd e-mail'
    it { expect(mail.to).to eq(user.system_setting.private_recipients_as_array) }
    it { expect(mail.subject).to eq(SSETTINGS_PSE_TITLE_PREFIX + period) }
    # it { expect(mail.body.encoded).to include(SSETTINGS_PSE_BODY_WEEK.gsub(I18n.t('tags.competence'), period) + user.signature)}
  end

  describe 'analysis e-mail' do
    let(:competence) { week.product_and_service_datum.competence }
    let(:mail) { described_class.send_prod_and_serv_to_analysis(week, user).deliver_now }

    it_behaves_like 'an psd e-mail'
    it { expect(mail.to).to eq([ANALYSIS_EMAIL]) }
    it { expect(mail.subject).to eq(user.system_setting.pse_processed_title(competence)) }
    # it { expect(mail.body.encoded).to eq(user.system_setting.pse_processed_body(competence)) }
  end

  describe 'client e-mail' do
    let(:competence) { week.product_and_service_datum.competence }
    let(:mail) { described_class.send_monthly_prod_and_serv_email(week, user).deliver_now }

    it_behaves_like 'an psd e-mail'
    it { expect(mail.to).to eq(user.system_setting.recipients_as_array) }
    it { expect(mail.subject).to eq(user.system_setting.pse_processed_title(competence)) }
    # it { expect(mail.body.encoded).to eq(user.system_setting.pse_processed_body(competence)) }
  end
end
