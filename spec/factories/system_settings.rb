FactoryGirl.define do
  factory :system_setting do
    pse_recipients_array SAMPLE_RECIPIENTS
    pse_private_recipients_array SAMPLE_RECIPIENTS
    re_title SSETTINGS_RE_TITLE
    re_body SSETTINGS_RE_BODY
    pse_title SSETTINGS_PSE_TITLE
    pse_body SSETTINGS_PSE_BODY
    user

    trait :invalid do
      pse_recipients_array nil
    end
  end
end
