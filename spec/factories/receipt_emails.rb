FactoryGirl.define do
  factory :receipt_email do
    value 3
    day_of_month 3
    company
    body SSETTINGS_RE_BODY
    recipients_array SAMPLE_RECIPIENTS

    trait :invalid do
      value nil
    end

    trait :pf_company do
      company { build(:company, :pessoa_fisica) }
    end

    trait :pj_company do
      company { build(:company) }
    end

    before(:create) do |receipt_email|
      receipt_email.company.save
    end
  end
end
