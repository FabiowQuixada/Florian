require 'rails_helper'

describe ModelHelper do
  describe 'donation' do
    let(:klass) { Donation.new }

    it { expect(klass.genderize('deactivated')).to eq 'deactivated.f.s' }
    it { expect(klass.model_gender).to eq 'f' }
    it { expect(klass.model_number).to eq 's' }
    it { expect(klass.was('updated')).to eq "Doação atualizada com sucesso!" }
    it { expect(klass.blank_error_message('donation_date')).to eq "O campo 'Data' é obrigatório;" }
  end

  describe 'receipt e-mail' do
    let(:klass) { ReceiptEmail.new }

    it { expect(klass.genderize('created')).to eq 'created.m.s' }
    it { expect(klass.model_gender).to eq 'm' }
    it { expect(klass.model_number).to eq 's' }
    it { expect(klass.was('updated')).to eq 'E-mail de recibo atualizado com sucesso!' }
    it { expect(klass.blank_error_message('company')).to eq "O campo 'Mantenedora' é obrigatório;" }
  end

  describe 'product and service datum' do
    let(:klass) { ProductAndServiceDatum.new }

    it { expect(klass.genderize('removed')).to eq 'removed.m.p' }
    it { expect(klass.model_gender).to eq 'm' }
    it { expect(klass.model_number).to eq 'p' }
    it { expect(klass.was('updated')).to eq "Produtos e serviços atualizados com sucesso!" }
    it { expect(klass.blank_error_message('competence')).to eq "O campo 'Competência' é obrigatório;" }
  end
end
