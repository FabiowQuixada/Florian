FactoryGirl.define do
  factory :bill do
    competence { Faker::Date.between(100.years.ago.change(day: 1), 100.years.from_now.change(day: 1)) }
    water { Faker::Number.between(100, 250) }
    energy { Faker::Number.between(90, 150) }
    telephone { Faker::Number.between(80, 120) }

    trait :invalid do
      water nil
    end
  end
end
