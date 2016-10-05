FactoryGirl.define do
  factory :product_and_service_week do
    product_and_service_datum
    number 3

    transient do
      service_data_count 2
    end

    after :build do |product_and_service_week, evaluator|
      build_list(:service_data, evaluator.service_data_count, product_and_service_week: product_and_service_week)
      product_and_service_week.product_data ||= build(:product_data, product_and_service_week: product_and_service_week)
    end

    trait :invalid do
      service_data nil
      product_data nil
    end

    trait :totals do
      number 6
    end

    trait :final do
      number 7
    end

    trait :helper do
      number 0
    end

    trait :finalized_datum do
      association :product_and_service_datum, factory: [:product_and_service_datum, :finalized]
    end

    trait :on_analysis_datum do
      association :product_and_service_datum, factory: [:product_and_service_datum, :on_analysis]
    end
  end
end
