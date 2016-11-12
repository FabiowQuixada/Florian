FactoryGirl.define do
  factory :donation do
    donation_date { Faker::Date.forward 1000 }
    remark { Faker::Lorem.sentence }
    value { Faker::Number.between(150, 1200) }
    maintainer

    trait :invalid do
      remark nil
      value nil
    end

    before :create do |donation|
      donation.maintainer.save
    end
  end
end
