FactoryGirl.define do
  factory :user do
    sequence(:name, 1) { |n| "Usuario #{n}" }
    sequence(:signature, 1) { |n| "Usuario #{n}" }
    email { Faker::Internet.email }
    password { 'Faker::Internet.password' }
    password_confirmation { 'Faker::Internet.password' }
    role

    after(:build) do |user|
      user.system_setting ||= build(:system_setting, user: user)
      user.bcc = user.email
    end

    trait :system do
      email SYSTEM_EMAIL
    end

    trait :common do
    end

    trait :guest do
      after(:build) do |user|
        user.role = build(:role, name: GUEST_ROLE, description: GUEST_ROLE)
      end
    end

    trait :admin do
      after(:build) do |user|
        user.role = build(:role, name: ADMIN_ROLE, description: ADMIN_ROLE)
      end
    end

    trait :invalid do
      email nil
    end
  end
end
