FactoryGirl.define do
  factory :contact do
    contact_type Contact.contact_types[:"Responsável"]
    sequence(:name, 1) { |n| "Contact #{n}" }
    company

    trait :invalid do
      company nil
    end

    trait :no_data do
      name nil
      position nil
      email_address nil
      telephone nil
      celphone nil
      fax nil
    end

    trait :with_phones do
      telephone '(35) 5475-6875'
      celphone '(54) 3 6475-6846'
      fax '(35) 5475-6875'
    end
  end
end
