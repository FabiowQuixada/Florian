require 'rails_helper'

describe ProductAndServiceDatum, type: :mailer do
  describe 'Product and service weekly e-mail' do
    let(:week) { create :product_and_service_week }
    let(:user) { build :user, :common }
    let(:mail) { FlorianMailer.send_weekly_prod_and_serv_email(week, user).deliver_now }
    let(:period) { week.start_date.to_s + ' ' + I18n.t('helpers.to') + ' ' + week.end_date.to_s }

    it 'renders the receiver email' do
      expect(mail.to).to eq(user.system_setting.private_recipients_as_array)
    end

    it 'renders the sender email' do
      expect(mail.from).to eq([SYSTEM_EMAIL])
    end

    it 'renders the e-mail title' do
      expect(mail.subject).to eq(SSETTINGS_PSE_TITLE_PREFIX + period)
    end

    it 'renders the e-mail body' do
      # expect(mail.body.encoded).to include(SSETTINGS_PSE_BODY_WEEK.gsub(I18n.t('tags.competence'), period) + user.signature)
    end

    it 'renders the users signature' do
      expect(mail.body.encoded).to include(user.signature)
    end

    it 'renders mails attachment' do
      expect(mail.attachments).to have(1).attachment
      attachment = mail.attachments[0]
      expect(attachment).to be_a_kind_of(Mail::Part)
      expect(attachment.content_type).to be_start_with('application/pdf;')
      expect(attachment.filename).to eq('relatorio_de_produtos_e_servicos.pdf')
    end
  end

  describe 'Product and service analysis e-mail' do
    let(:week) { create :product_and_service_week }
    let(:competence) { week.product_and_service_datum.competence }
    let(:user) { build :user, :common }
    let(:mail) { FlorianMailer.send_prod_and_serv_to_analysis(week, user).deliver_now }

    it 'renders the receiver email' do
      expect(mail.to).to eq([ANALYSIS_EMAIL])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq([SYSTEM_EMAIL])
    end

    it 'renders the e-mail title' do
      expect(mail.subject).to eq(user.system_setting.pse_processed_title(competence))
    end

    it 'renders the e-mail body' do
      # expect(mail.body.encoded).to eq(user.system_setting.pse_processed_body(competence))
    end

    it 'renders the users signature' do
      expect(mail.body.encoded).to include(user.signature)
    end

    it 'renders mails attachment' do
      expect(mail.attachments).to have(1).attachment
      attachment = mail.attachments[0]
      expect(attachment).to be_a_kind_of(Mail::Part)
      expect(attachment.content_type).to be_start_with('application/pdf;')
      expect(attachment.filename).to eq('relatorio_de_produtos_e_servicos.pdf')
    end
  end

  describe 'Product and service client e-mail' do
    let(:week) { create :product_and_service_week }
    let(:competence) { week.product_and_service_datum.competence }
    let(:user) { build :user, :common }
    let(:mail) { FlorianMailer.send_monthly_prod_and_serv_email(week, user).deliver_now }

    it 'renders the receiver email' do
      expect(mail.to).to eq(user.system_setting.recipients_as_array)
    end

    it 'renders the sender email' do
      expect(mail.from).to eq([SYSTEM_EMAIL])
    end

    it 'renders the e-mail title' do
      expect(mail.subject).to eq(user.system_setting.pse_processed_title(competence))
    end

    it 'renders the e-mail body' do
      # expect(mail.body.encoded).to eq(user.system_setting.pse_processed_body(competence))
    end

    it 'renders the users signature' do
      expect(mail.body.encoded).to include(user.signature)
    end

    it 'renders mails attachment' do
      expect(mail.attachments).to have(1).attachment
      attachment = mail.attachments[0]
      expect(attachment).to be_a_kind_of(Mail::Part)
      expect(attachment.content_type).to be_start_with('application/pdf;')
      expect(attachment.filename).to eq('relatorio_de_produtos_e_servicos.pdf')
    end
  end
end
