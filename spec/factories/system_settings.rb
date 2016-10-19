FactoryGirl.define do
  factory :system_setting do
    pse_recipients_array SAMPLE_RECIPIENTS
    pse_private_recipients_array SAMPLE_RECIPIENTS
    re_title I18n.t('defaults.report.receipt.email_title')
    re_body I18n.t('defaults.report.receipt.email_body')
    pse_title I18n.t('defaults.report.product_and_service.email_title')
    pse_body I18n.t('defaults.report.product_and_service.monthly_email_body')
    user

    trait :invalid do
      pse_recipients_array nil
    end
  end
end
