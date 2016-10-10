FactoryGirl.define do
  factory :system_setting do
    pse_recipients_array SAMPLE_RECIPIENTS
    pse_private_recipients_array SAMPLE_RECIPIENTS
    re_title SETTINGS_RE_TITLE
    re_body SETTINGS_RE_BODY
    pse_title SETTINGS_PSE_TITLE
    pse_body SETTINGS_PSE_BODY
    user

    trait :invalid do
      pse_recipients_array nil
    end
  end
end
