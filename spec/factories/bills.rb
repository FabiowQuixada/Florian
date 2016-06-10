FactoryGirl.define do
  factory :bill do
    competence Date.today
    water 0.00
    energy 0.00
    telephone 0.00

    trait :invalid do
      water nil
    end
  end
end
