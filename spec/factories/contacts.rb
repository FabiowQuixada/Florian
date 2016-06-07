FactoryGirl.define do
  factory :contact do
    contact_type Contact.contact_types[:"Responsável"]
    company
  end
end
