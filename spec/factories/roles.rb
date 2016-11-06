FactoryGirl.define do
  factory :role do
    name { Faker::Team.name }
    description { Faker::Lorem.paragraph }

    trait :invalid do
      name nil
    end

    trait :admin do
      name 'Admin'
    end
  end
end
