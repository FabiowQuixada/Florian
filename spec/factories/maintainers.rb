FactoryGirl.define do
  factory :maintainer do
    entity_type 'company'
    cnpj { BlaBla::CNPJ.formatado }
    registration_name { "#{Faker::Company.name} #{Faker::Number.number(5)}" }
    name { "#{Faker::Company.name} #{Faker::Number.number(5)}" }
    address Faker::Address.street_address
    category :medium
    group :maintainer

    trait :invalid do
      entity_type nil
      cnpj nil
    end

    trait :company do
      entity_type 'company'
      cnpj { BlaBla::CNPJ.formatado }
      cpf nil
    end

    trait :person do
      entity_type 'person'
      cpf { BlaBla::CPF.formatado }
      cnpj nil
      registration_name nil
    end

    trait :with_donations do
      after :build do |maintainer|
        maintainer.donations = build_list(:donation, 3, maintainer: maintainer)
      end
    end

    trait :with_invalid_donations do
      after :build do |maintainer|
        maintainer.donations = build_list(:donation, 3, maintainer: maintainer, donation_date: nil)
      end
    end

    trait :with_contacts do
      after :build do |maintainer|
        maintainer.contacts = build_list(:contact, 3, maintainer: maintainer)
      end
    end
  end
end
