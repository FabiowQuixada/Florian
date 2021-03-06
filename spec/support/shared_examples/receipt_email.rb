shared_examples 'an receipt e-mail' do
  let(:attachment) { mail.attachments[0] }

  it { expect(mail.from).to eq([SYSTEM_EMAIL]) }
  it { expect(mail.subject).to include(I18n.localize(competence, format: :competence).capitalize) }
  it { expect(body_text(mail)).to include(user.full_signature) }
  it { expect(mail.attachments).to have(1).attachment }
  it { expect(attachment).to be_a_kind_of(Mail::Part) }
  it { expect(attachment.content_type).to be_start_with('application/pdf;') }
  it { expect(attachment.filename).to eq "#{I18n.t('report.attachment.receipt_email')}_#{I18n.l(competence, format: '%B').downcase}_#{competence.year}.pdf" }
  it { expect(mail).to eq ActionMailer::Base.deliveries.last }
end
