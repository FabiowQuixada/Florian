RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)

    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end

    role1 = Role.create(name: 'Admin', description: 'Administrador')
    User.create(name: 'Sistema', email: SYSTEM_EMAIL, password: 'fulano0123', password_confirmation: 'fulano0123', bcc: 'teste@test.com', signature: '(Assinatura)', role: role1)

    role2 = Role.create(name: "Usuário", description: 'Usuário comum')
    User.create(name: 'Inativo', email: 'teste_inativo@yahoo.com.br', password: 'usuario_teste', password_confirmation: 'usuario_teste', bcc: 'teste@test.com', signature: '(Assinatura)', role: role2, active: false)
    User.create(name: 'Comum', email: 'teste_comum@yahoo.com.br', password: 'usuario_comum', password_confirmation: 'usuario_comum', bcc: 'teste@test.com', signature: '(Assinatura)', role: role2)

    comp1 = Company.create(entity_type: Company.entity_types[:"Pessoa Jurídica"], name: 'Empresa I', registration_name: 'Empresa I Ltda.', cnpj: '31162488000187', category: Company.categories[:"2 (Entre R$ 300,00 e R$ 600,00)"], address: 'lala', group: Company.groups[:Mantenedora])

    Donation.create(value: 0.00, donation_date: Time.now, remark: '02 potes de creme', company: comp1)

    FactoryGirl.create :receipt_email
    FactoryGirl.create :bill
    FactoryGirl.create :product_and_service_datum
    FactoryGirl.create :donation
  end
end
