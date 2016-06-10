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
  end
end
