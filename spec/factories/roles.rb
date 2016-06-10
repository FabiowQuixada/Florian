FactoryGirl.define do
  factory :role do
    sequence(:name, 1) { |n| "Grupo #{n}" }
    description 'Grupo'

    trait :invalid do
      name nil
    end
  end
end
