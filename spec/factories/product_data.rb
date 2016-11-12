FactoryGirl.define do
  factory :product_data do
    product_and_service_week

    trait :invalid do
      mesh nil
    end

    trait :populated do
      mesh { Faker::Number.between(5, 15) }
      cream { Faker::Number.between(5, 15) }
      protector { Faker::Number.between(5, 15) }
      silicon { Faker::Number.between(5, 15) }
      mask { Faker::Number.between(5, 15) }
      foam { Faker::Number.between(5, 15) }
      skin_expander { Faker::Number.between(5, 15) }
      cervical_collar { Faker::Number.between(5, 15) }
    end
  end
end
