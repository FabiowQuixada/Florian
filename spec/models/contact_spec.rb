require 'rails_helper'

describe Contact, type: :model do
  it { is_expected.to define_enum_for(:contact_type) }
  it { is_expected.to belong_to :company }
  # it { is_expected.to validate_inclusion_of(:contact_type).in_array(Contact.contact_types.values) }

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
end
