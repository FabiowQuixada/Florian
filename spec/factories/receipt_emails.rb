FactoryGirl.define do
  factory :receipt_email do
    value 3
    day_of_month 3
    maintainer
    body SETTINGS_RE_BODY
    recipients_array SAMPLE_RECIPIENTS

    trait :invalid do
      value nil
    end

    trait :person_maintainer do
      maintainer { build(:maintainer, :person) }
    end

    trait :company_maintainer do
      maintainer { build(:maintainer) }
    end

    trait :with_history do
      after :build do |receipt_email|
        receipt_email.email_histories = build_list(:email_history, 3, receipt_email: receipt_email)
      end
    end

    before :create do |receipt_email|
      receipt_email.maintainer.save
    end
  end
end
