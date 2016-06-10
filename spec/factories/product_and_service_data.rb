FactoryGirl.define do
  factory :product_and_service_datum do
    status ProductAndServiceDatum.statuses[:created]
    competence { Faker::Date.between(100.years.ago.change(day: 1), 100.years.from_now.change(day: 1)) }

    transient do
      product_and_service_weeks_count 7
    end

    after(:create) do |product_and_service_datum, evaluator|
      create_list(:product_and_service_week, evaluator.product_and_service_weeks_count, product_and_service_datum: product_and_service_datum)
    end

    trait :invalid do
      competence nil
    end
  end
end
