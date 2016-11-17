require 'rails_helper'

describe Contact, type: :model do
  it { is_expected.to belong_to :maintainer }

  it 'does not save if its attributes are empty' do
    model = build(:contact, :no_data)
    model.valid?
    expect(model.errors.full_messages).to include I18n.t('errors.contact.all_empty')
  end

  it 'validates phones' do
    model = build(:contact, :with_phones)

    expect(model.telephone).to match(PHONE_FORMAT)
    expect(model.celphone).to match(CELPHONE_FORMAT)
    expect(model.fax).to match(PHONE_FORMAT)
  end

  # Methods #################################################################################
  describe '#validate_model' do
    let(:contact) { build :contact, :no_data }
    it { expect(contact.send(:validate_model).full_messages).to include I18n.t('errors.contact.all_empty') }
  end

  describe '#not_filled?' do
    it { expect((build :contact, name: 'Joao').send(:not_filled?, :name)).to be false }
    it { expect((contact = build :contact, :nameless).send(:not_filled?, contact.name)).to be true }
    it { expect((build :contact, telephone: '12 3456 7890').send(:not_filled?, :telephone)).to be false }
    it { expect((contact = build :contact, :phoneless).send(:not_filled?, contact.telephone)).to be true }
  end

  describe '#no_attrs_filled?' do
    it { expect((build :contact, :no_data).send(:no_attrs_filled?)).to be true }
    it { expect((build :contact, :with_phones).send(:no_attrs_filled?)).to be false }
  end
end
