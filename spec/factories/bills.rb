FactoryGirl.define do
  factory :bill do
    competence { Faker::Date.between(100.years.ago.change(day: 1), 100.years.from_now.change(day: 1)) }
    water 0.00
    energy 0.00
    telephone 0.00

    trait :invalid do
      water nil
    end
  end
end
