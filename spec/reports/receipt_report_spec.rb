require 'rails_helper'

describe ReceiptReport do
  describe 'weekly report' do
    let(:receipt) { build :receipt_email }
    let(:date) { Date.yesterday }
    let(:rendered_pdf) { described_class.new('/tmp/prod_serv.pdf', receipt, date).pdf.render }
    let(:text_analysis) { PDF::Inspector::Text.analyze(rendered_pdf) }
    let(:page_analysis) { PDF::Inspector::Page.analyze(rendered_pdf) }
    let(:main_paragraph) { text_analysis.strings[3..6] }

    it { expect(text_analysis.strings[0]).to eq(I18n.t('report.title.receipt')) }

    it { expect(text_analysis.strings).to include(ActionController::Base.helpers.number_to_currency(receipt.value)) }

    it 'displays receipt text' do
      main_paragraph.each do |text_frag|
        expect(receipt.processed_receipt_text(date)).to include text_frag
      end
    end

    it { expect(text_analysis.strings).to include I18n.t('report.other.banking.deposit_data') }
    it { expect(text_analysis.strings).to include "#{I18n.t('report.other.banking.bank')}: Itaú (341)" }
    it { expect(text_analysis.strings).to include "#{I18n.t('report.other.banking.agency')}: 8373" }
    it { expect(text_analysis.strings).to include "#{I18n.t('report.other.banking.account')}: 14373-7" }

    it { expect(text_analysis.strings).to include "#{SystemSetting.first.city}, #{I18n.localize(Date.today, format: :long)}" }

    it { expect(text_analysis.strings[-3]).to eq I18n.t('report.footer.address') }
    it { expect(text_analysis.strings[-2]).to eq I18n.t('report.footer.phone') }
    it { expect(text_analysis.strings[-1]).to eq I18n.t('report.footer.email') }

    it { expect(page_analysis.pages.size).to eq(1) }
  end
end
