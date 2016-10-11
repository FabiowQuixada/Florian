FactoryGirl.define do
  factory :donation do
    sequence(:remark, 1) { |n| "Observacao #{n}" }
    company

    trait :invalid do
      remark nil
      value nil
    end

    before :create do |donation|
      donation.company.save
    end
  end
end
