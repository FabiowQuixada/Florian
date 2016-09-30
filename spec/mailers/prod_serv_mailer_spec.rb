require 'rails_helper'

describe ProdServMailer, type: :mailer do
  let(:week) { build :product_and_service_week }
  let(:user) { build :user, :common }

  describe 'weekly e-mail' do
    let(:period) { week.period }
    let(:competence) { week.product_and_service_datum.competence }
    let(:mail) do
      mail = instance_double 'Mail::Message'
      attachment = instance_double 'Mail::Part'
      body = instance_double 'Mail::Body'
      part = instance_double 'Mail::Part'
      part_body = instance_double 'Mail::Part'

      allow(mail).to receive(:to).and_return(user.system_setting.recipients_as_array)
      allow(mail).to receive(:subject).and_return(user.system_setting.pse_processed_title)
      allow(mail).to receive(:body).and_return(body)

      allow(mail).to receive(:from).and_return(['apoioaoqueimado@yahoo.com.br'])
      allow(mail).to receive(:attachments).and_return([attachment])

      allow(attachment).to receive(:filename).and_return('relatorio_de_produtos_e_servicos_' + I18n.l(competence, format: '%B').downcase + '_' + competence.year.to_s + '.pdf')
      allow(attachment).to receive(:content_type).and_return('application/pdf;')

      allow(body).to receive(:parts).and_return([part])

      allow(part).to receive(:content_type).and_return('text/plain; charset=UTF-8')
      allow(part).to receive(:body).and_return(part_body)

      allow(part_body).to receive(:raw_source).and_return(user.system_setting.pse_processed_body)

      mail
    end

    it_behaves_like 'an psd e-mail'
    it { expect(described_class).to receive(:send_weekly_email).with(week, user).and_return(mail) }
    it { expect(mail.to).to eq(user.system_setting.private_recipients_as_array) }
    it { expect(mail.subject).to eq(SSETTINGS_PSE_TITLE_PREFIX + period) }
    it do
      expect(body_text(mail)).to eq(SSETTINGS_PSE_BODY_WEEK.gsub(I18n.t('tags.competence'), period) + user.full_signature)
    end
  end

  describe 'analysis e-mail' do
    let(:competence) { week.product_and_service_datum.competence }
    let(:mail) { described_class.send_to_analysis(week, user).deliver_now }

    it_behaves_like 'an psd e-mail'
    it { expect(mail.to).to eq([ANALYSIS_EMAIL]) }
    it { expect(mail.subject).to eq(user.system_setting.pse_processed_title(competence)) }
    it { expect(body_text(mail)).to eq(user.system_setting.pse_processed_body(competence)) }
  end

  describe 'maintainers e-mail' do
    let(:competence) { week.product_and_service_datum.competence }
    let(:mail) { described_class.send_monthly_email(week, user).deliver_now }

    it_behaves_like 'an psd e-mail'
    it { expect(mail.to).to eq(user.system_setting.recipients_as_array) }
    it { expect(mail.subject).to eq(user.system_setting.pse_processed_title(competence)) }
    it { expect(body_text(mail)).to eq(user.system_setting.pse_processed_body(competence)) }
  end
end
