FactoryGirl.define do
  factory :product_and_service_datum do
    status { ProductAndServiceDatum.statuses[:created] }
    competence { Faker::Date.between(100.years.ago.change(day: 1), 100.years.from_now.change(day: 1)) }

    after :build do |datum|
      datum.product_and_service_weeks = []

      (NUMBER_OF_WEEKS + 2).times do |number|
        week_start = datum.competence.beginning_of_month + (7 * number).days

        datum.product_and_service_weeks <<
          build(:product_and_service_week,
                product_and_service_datum: datum,
                start_date: week_start,
                end_date: week_start + 5.days,
                number: number + 1)
      end
    end

    trait :populated do
      after :build do |datum|
        datum.product_and_service_weeks = []

        (NUMBER_OF_WEEKS + 2).times do |number|
          week_start = datum.competence.beginning_of_month + (7 * number).days

          datum.product_and_service_weeks <<
            build(:product_and_service_week, :populated,
                  product_and_service_datum: datum,
                  start_date: week_start,
                  end_date: week_start + 5.days,
                  number: number + 1)
        end
      end
    end

    trait :invalid do
      status nil
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

    trait :random_status do
      status { ProductAndServiceDatum.statuses.keys[rand(ProductAndServiceDatum.statuses.length)] }
    end
  end
end
