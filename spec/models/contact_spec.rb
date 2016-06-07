require 'rails_helper'

describe Contact, type: :model do
  it { should define_enum_for(:contact_type) }
  # it { should validate_inclusion_of(:contact_type).in_array(Contact.contact_types.values) }
end
