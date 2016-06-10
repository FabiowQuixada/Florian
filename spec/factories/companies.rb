FactoryGirl.define do
  factory :company do
    entity_type Company.entity_types[:"Pessoa Jurídica"]
    cnpj { BlaBla::CNPJ.formatado }
    sequence(:registration_name, 1) { |n| "Company #{n}" }
    sequence(:name, 1) { |n| "Company #{n} Ltda." }
    address 'Rua X'
    category Company.categories[:"2 (Entre R$ 300,00 e R$ 600,00)"]
    group Company.groups[:Mantenedora]

    transient do
      contacts_count 7
    end

    after(:create) do |company, evaluator|
      create_list(:contact, evaluator.contacts_count, company: company)
    end

    trait :invalid do
      entity_type nil
      cnpj nil
    end
  end
end
