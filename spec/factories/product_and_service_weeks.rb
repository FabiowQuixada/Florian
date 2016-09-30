FactoryGirl.define do
  factory :product_and_service_week do
    product_and_service_datum
    number 3

    transient do
      service_data_count 2
    end

    after(:build) do |product_and_service_week, evaluator|
      build_list(:service_data, evaluator.service_data_count, product_and_service_week: product_and_service_week)
      product_and_service_week.product_data ||= build(:product_data, product_and_service_week: product_and_service_week)
    end

    trait :invalid do
      service_data nil
      product_data nil
    end
  end
end
