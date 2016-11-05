require 'rails_helper'

describe LocaleHelper do
  let(:dummy_class) { Class.new { include LocaleHelper } }

  it { expect(dummy_class.new.genderize_full_tag(Donation.new, 'helpers.action.new')). to eq 'Nova' }
  it { expect(dummy_class.new.genderize_full_tag(ReceiptEmail.new, 'helpers.action.new')). to eq 'Novo' }
  it { expect(dummy_class.new.genderize_full_tag(Maintainer.new, 'helpers.action.update_and_new')). to eq 'Salvar e cadastrar nova' }
  it { expect(dummy_class.new.genderize_full_tag(User.new, 'helpers.action.update_and_new')). to eq 'Salvar e cadastrar novo' }
end
