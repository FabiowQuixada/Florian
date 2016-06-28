FactoryGirl.define do
  factory :donation do
    remark 'Observacao'
    company

    trait :invalid do
      remark nil
      value nil
    end

    before(:create) do |donation|
      donation.company.save
    end
  end
end
