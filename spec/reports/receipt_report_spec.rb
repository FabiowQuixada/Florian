require 'rails_helper'

describe ReceiptReport do
  describe 'weekly report' do
    let(:receipt) { build :receipt_email }
    let(:date) { Date.yesterday }
    let(:rendered_pdf) { described_class.new('/tmp/prod_serv.pdf', receipt, date).pdf.render }
    let(:text_analysis) { PDF::Inspector::Text.analyze(rendered_pdf) }
    let(:page_analysis) { PDF::Inspector::Page.analyze(rendered_pdf) }

    it { expect(text_analysis.strings[0]).to eq(I18n.t('report.title.receipt')) }

    it { expect(text_analysis.strings).to include(ActionController::Base.helpers.number_to_currency(receipt.value)) }

    it 'displays receipt text' do
      text_analysis.strings[3..7].each do |text_frag|
        expect(receipt.processed_receipt_text(date)).to include text_frag
      end
    end

    it { expect(text_analysis.strings).to include("Dados para depósito") }
    it { expect(text_analysis.strings).to include("Banco: Itaú (341)") }
    it { expect(text_analysis.strings).to include("Agência: 8373") }
    it { expect(text_analysis.strings).to include('Conta Corrente: 14373-7') }

    it { expect(text_analysis.strings).to include('Fortaleza, ' + I18n.localize(Date.today, format: :long)) }

    it { expect(text_analysis.strings[-3]).to eq('Rua Visconde de Sabóia, nº 75 – Salas 01 a 16 - Centro – Cep: 60.030-090 - Fortaleza – CE') }
    it { expect(text_analysis.strings[-2]).to eq('Fone: 55 85 3251-1093') }
    it { expect(text_analysis.strings[-1]).to eq('E-mail: apoioaoqueimado@yahoo.com.br') }

    it { expect(page_analysis.pages.size).to eq(1) }
  end
end
