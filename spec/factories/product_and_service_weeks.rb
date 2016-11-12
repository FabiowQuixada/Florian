FactoryGirl.define do
  factory :product_and_service_week do
    product_and_service_datum
    number { Faker::Number.between(1, ProductAndServiceWeek::TOTALS_NUMBER - 1) }

    transient { service_data_count 2 }

    after :build do |week|
      week.service_data = []
      week.service_data << build(:service_data, :attendance, product_and_service_week: week)
      week.service_data << build(:service_data, :return, product_and_service_week: week)
      week.product_data = build(:product_data, product_and_service_week: week)
    end

    trait :populated do
      after :build do |week|
        week.service_data = []
        week.service_data << build(:service_data, :populated, :attendance, product_and_service_week: week)
        week.service_data << build(:service_data, :populated, :return, product_and_service_week: week)
        week.product_data = build(:product_data, :populated, product_and_service_week: week)
      end
    end

    trait :invalid do
      service_data nil
      product_data nil
    end

    trait :common do
      number { rand(ProductAndServiceWeek::TOTALS_NUMBER - 2) }
    end

    trait :totals do
      number ProductAndServiceWeek::TOTALS_NUMBER
    end

    trait :final do
      number ProductAndServiceWeek::FINAL_NUMBER
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
