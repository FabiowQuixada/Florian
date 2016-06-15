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
    User.create(name: 'Comum', email: 'teste_comum@yahoo.com.br', password: 'usuario_comum', password_confirmation: 'usuario_comum', bcc: 'teste@test.com', signature: '(Assinatura)', role: role2)
  end
end
