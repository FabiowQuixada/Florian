shared_examples 'a psd e-mail' do
  let(:attachment) { mail.attachments[0] }

  it { expect(mail.from).to eq([SYSTEM_EMAIL]) }
  it { expect(body_text(mail)).to include(user.full_signature) }
  it { expect(mail.attachments).to have(1).attachment }
  it { expect(attachment).to be_a_kind_of(Mail::Part) }
  it { expect(attachment.content_type).to be_start_with('application/pdf;') }
  it { expect(attachment.filename).to eq "#{I18n.t('report.attachment.prod_serv_report')}_#{I18n.l(competence, format: '%B').downcase}_#{competence.year}.pdf" }
end
