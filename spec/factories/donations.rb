FactoryGirl.define do
  factory :donation do
    sequence(:remark, 1) { |n| "Observacao #{n}" }
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
