FactoryGirl.define do
  factory :company do
    entity_type 'company'
    cnpj { BlaBla::CNPJ.formatado }
    sequence(:registration_name, 1) { |n| "Company #{n}" }
    sequence(:name, 1) { |n| "Company #{n} Ltda." }
    address 'Rua X'
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
      after(:build) do |company|
        company.donations = build_list(:donation, 3, company: company)
      end
    end

    trait :with_invalid_donations do
      after(:build) do |company|
        company.donations = build_list(:donation, 3, company: company, donation_date: nil)
      end
    end

    trait :with_contacts do
      after(:build) do |company|
        company.contacts = build_list(:contact, 3, company: company)
      end
    end
  end
end
