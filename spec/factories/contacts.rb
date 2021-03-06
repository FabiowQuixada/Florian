FactoryGirl.define do
  factory :contact do
    name { Faker::Name.name }
    maintainer

    trait :nameless do
      name ''
    end

    trait :phoneless do
      telephone ''
      celphone ''
      fax ''
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
