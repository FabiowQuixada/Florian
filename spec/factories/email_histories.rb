FactoryGirl.define do
  factory :email_history do
    value 3
    body SSETTINGS_RE_BODY
    send_type EmailHistory.send_types[:auto]
    recipients_array Faker::Internet.email
    user
    receipt_email

    trait :invalid do
      recipients_array nil
    end

    trait :auto do
      send_type EmailHistory.send_types[:auto]
    end

    trait :resend do
      send_type EmailHistory.send_types[:resend]
    end

    trait :test do
      send_type EmailHistory.send_types[:test]
    end
  end
end
