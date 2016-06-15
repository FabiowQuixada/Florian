FactoryGirl.define do
  factory :user do
    sequence(:name, 1) { |n| "Usuario #{n}" }
    email { Faker::Internet.email }
    signature 'Att,\nJoao'
    bcc { Faker::Internet.email }
    password { 'Faker::Internet.password' }
    password_confirmation { 'Faker::Internet.password' }
    role

    after(:build) do |user, _evaluator|
      user.system_setting ||= build(:system_setting, user: user)
    end

    trait :system do
      email SYSTEM_EMAIL
    end

    trait :common do
      email ADMIN_EMAIL
    end

    trait :admin do
      email ADMIN_EMAIL
    end

    trait :invalid do
      email nil
    end
  end
end
