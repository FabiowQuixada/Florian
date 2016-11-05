FactoryGirl.define do
  factory :product_and_service_datum do
    status ProductAndServiceDatum.statuses[:created]
    competence { Faker::Date.between(100.years.ago.change(day: 1), 100.years.from_now.change(day: 1)) }

    after :build do |product_and_service_datum|
      product_and_service_datum.weeks.each do |week|
        week.product_and_service_datum ||= product_and_service_datum
      end
    end

    trait :invalid do
      competence nil
    end

    trait :created do
      status ProductAndServiceDatum.statuses[:created]
    end

    trait :on_analysis do
      status ProductAndServiceDatum.statuses[:on_analysis]
    end

    trait :finalized do
      status ProductAndServiceDatum.statuses[:finalized]
    end
  end
end
