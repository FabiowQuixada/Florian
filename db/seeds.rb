require 'factory_girl_rails'

if Rails.env.showcase?
  guest_role = Role.create(name: SHOWCASE_USER, description: SHOWCASE_USER)

  GUEST_USERS_NUMBERS.each do |number|
    User.create name: "Guest#{number}",
                email: "guest_#{number}@florian.com",
                password: SHOWCASE_PASSWORD,
                password_confirmation: SHOWCASE_PASSWORD,
                role: guest_role
  end
else
  role1 = Role.create(name: 'Admin', description: 'Administrador')
  role2 = Role.create(name: "Usuário", description: 'Usuário comum')
  role3 = Role.create(name: "Administração", description: 'Presidência')
  role4 = Role.create(name: "Secretária 1", description: '(Renata)')
  role5 = Role.create(name: "Secretária 2", description: '(Lucivania)')

  User.create(name: 'Sistema', email: SYSTEM_EMAIL, password: 'fulano0123', password_confirmation: 'fulano0123', role: role1)
  User.create(name: 'Fabiow', email: ADMIN_EMAIL, password: 'fulano0123', password_confirmation: 'fulano0123', role: role1)
  User.create(name: 'Inativo', email: 'teste_inativo@yahoo.com.br', password: 'usuario_teste', password_confirmation: 'usuario_teste', role: role2, active: false)
  User.create(name: 'Comum', email: 'teste_comum@yahoo.com.br', password: 'usuario_comum', password_confirmation: 'usuario_comum', role: role2)
  User.create(name: 'Edmar', email: 'edmarmaciel@gmail.com', password: '35348456456', password_confirmation: '35348456456', role: role3)
  User.create(name: "Márcia", email: 'marciattm@hotmail.com', password: '34578933', password_confirmation: '34578933', role: role3)
  User.create(name: 'Renata', email: 'renata.sbq@gmail.com', password: '4453566486', password_confirmation: '4453566486', role: role4)
  User.create(name: "Lucivânia", email: 'lucivania_nojosa@hotmail.com', password: '98574325298', password_confirmation: '98574325298', role: role5)
end


if Rails.env.production?
  ExcelParser.parse
else
  30.times { FactoryGirl.create :maintainer }
  50.times { FactoryGirl.create :donation }
  20.times { FactoryGirl.create :donation, :with_remark }
  30.times { FactoryGirl.create :receipt_email, :showcase }

  (0..6).each { |m| FactoryGirl.create :product_and_service_datum, competence: Date.today - m.months }
  (0..50).each { |m| FactoryGirl.create :bill, competence: Date.today - m.months }
end
