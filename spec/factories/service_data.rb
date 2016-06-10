FactoryGirl.define do
  factory :service_data do
    product_and_service_week
    service_type ServiceData.service_types[:return]

    trait :invalid do
      mesh nil
    end
  end
end
