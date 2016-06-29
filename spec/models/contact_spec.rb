require 'rails_helper'

describe Contact, type: :model do
  it { should define_enum_for(:contact_type) }
  it { should belong_to :company }
  # it { should validate_inclusion_of(:contact_type).in_array(Contact.contact_types.values) }

  it 'does not save if its attributes are empty' do
    model = build(:contact, :no_data)
    model.valid?
    expect(model.errors.full_messages).to include I18n.t('errors.contact.all_empty')
  end
end
