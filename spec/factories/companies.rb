FactoryGirl.define do
  factory :company do
    entity_type "Pessoa Jurídica"
    cnpj { BlaBla::CNPJ.formatado }
    sequence(:registration_name, 1) { |n| "Company #{n}" }
    sequence(:name, 1) { |n| "Company #{n} Ltda." }
    address 'Rua X'
    category '2 (Entre R$ 300,00 e R$ 600,00)'
    group 'Mantenedora'

    # transient do
    #   contacts_count 7
    # end

    # after(:create) do |company, evaluator|
    #   create_list(:contact, evaluator.contacts_count, company: company)
    # end

    trait :invalid do
      entity_type nil
      cnpj nil
    end

    trait :pessoa_fisica do
      entity_type "Pessoa Jurídica"
      cpf { BlaBla::CPF.formatado }
      cnpj nil
      registration_name nil
    end

    trait :with_donations do
      after(:create) do |company|
        create_list(:donation, 3, company: company)
      end
    end
  end
end
