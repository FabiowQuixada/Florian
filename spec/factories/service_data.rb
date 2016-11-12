FactoryGirl.define do
  factory :service_data do
    product_and_service_week
    service_type ServiceData.service_types[:return]

    trait :invalid do
      mesh nil
    end

    trait :attendance do
      service_type ServiceData.service_types[:attendance]
    end

    trait :return do
      service_type ServiceData.service_types[:return]
    end

    trait :populated do
      psychology { Faker::Number.between(5, 15) }
      physiotherapy { Faker::Number.between(5, 15) }
      plastic_surgery { Faker::Number.between(5, 15) }
      mesh { Faker::Number.between(5, 15) }
      gynecology { Faker::Number.between(5, 15) }
      occupational_therapy { Faker::Number.between(5, 15) }
    end
  end
end
