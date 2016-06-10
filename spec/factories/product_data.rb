FactoryGirl.define do
  factory :product_data do
    product_and_service_week

    trait :invalid do
      mesh nil
    end
  end
end
