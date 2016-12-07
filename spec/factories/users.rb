FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'Faker::Internet.password'
    password_confirmation 'Faker::Internet.password'
    role

    after :build do |user|
      user.bcc = user.email
      user.signature = user.name
    end

    trait :system do
      email SYSTEM_EMAIL
    end

    trait :common do
    end

    trait :guest do
      after :build do |user|
        user.role = build(:role, name: GUEST_ROLE, description: GUEST_ROLE)
      end
    end

    trait :admin do
      after :build do |user|
        user.role = build(:role, name: ADMIN_ROLE, description: ADMIN_ROLE)
      end
    end

    trait :invalid do
      email nil
    end
  end
end
