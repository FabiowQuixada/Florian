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

    FactoryGirl.create :system_setting

    role1 = Role.create(name: ADMIN_ROLE, description: 'Administrador')
    User.create(name: 'Sistema', email: SYSTEM_EMAIL, password: 'fulano0123', password_confirmation: 'fulano0123', bcc: 'teste@test.com', role: role1)

    role2 = Role.create(name: "Usuário", description: 'Usuário comum')
    Role.create(name: 'Grupo sem usuario', description: 'desc')
    User.create(name: 'Inativo', email: 'teste_inativo@yahoo.com.br', password: 'usuario_teste', password_confirmation: 'usuario_teste', bcc: 'teste@test.com', role: role2, active: false)
    User.create(name: 'Comum', email: 'teste_comum@yahoo.com.br', password: 'usuario_comum', password_confirmation: 'usuario_comum', bcc: 'teste@test.com', role: role2)

    FactoryGirl.create :maintainer, :with_contacts, :with_donations
    FactoryGirl.create :maintainer, category: :low
    FactoryGirl.create :maintainer, name: 'Maintainer in the `maintainer` group', group: :maintainer
    FactoryGirl.create :maintainer, name: 'Maintainer in the `punctual` group', group: :punctual
    comp1 = Maintainer.create(entity_type: 'company', name: 'Empresa I', registration_name: 'Empresa I Ltda.', cnpj: '31162488000187', category: 'medium', address: 'lala', group: 'maintainer')

    Donation.create(value: 0.00, donation_date: Time.now, remark: '02 potes de creme', maintainer: comp1)

    FactoryGirl.create :receipt_email, :with_history
    FactoryGirl.create :bill, water: 4, energy: 5
    FactoryGirl.create :product_and_service_datum
    FactoryGirl.create :donation
  end
end
