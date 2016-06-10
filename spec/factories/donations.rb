FactoryGirl.define do
  factory :donation do
    remark 'Observacao'
    company

    trait :invalid do
      remark nil
      value nil
    end
  end
end
