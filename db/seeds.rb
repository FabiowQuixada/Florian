# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

role1 = Role.create({name: "Admin", description: 'Administrador'})
role2 = Role.create({name: "Usuário", description: 'Usuário comum'})

user1 = User.create({name: "Sistema", email: "apoioaoqueimado@yahoo.com.br", password: "fulano0123", password_confirmation: "fulano0123", role: role1})
user2 = User.create({name: "Fabiow", email: "ftquixada@gmail.com", password: "fulano0123", password_confirmation: "fulano0123", role: role1})
user3 = User.create({name: "Renata", email: "fquixada@yahoo.com.br", password: "senha_renata", password_confirmation: "senha_renata", role: role2})

conf = EmailConfiguration.create({signature: 'Joao', bcc: 'ftquixada@gmail.com', test_recipient: 'ftquixada@gmail.com'})

comp1 = Company.create(simple_name: "Empresa I", long_name: "Empresa I Ltda.", cnpj: "31162488000187", category: 1, address: "lala", group: 1)
comp2 = Company.create(simple_name: "Empresa II", long_name: "Empresa II Ltda.", cnpj: "34.781.467/0001-38", category: 2, address: "lala",  group: 2)
comp3 = Company.create(simple_name: "Empresa III", long_name: "Empresa III Ltda.", cnpj: "01.476.667/0001-28", category: 3, address: "lala",  group: 3)
comp4 = Company.create(simple_name: "Empresa IV", long_name: "Empresa IV Ltda.", cnpj: "46.426.366/0001-28", category: 1, address: "lala",  group: 3)
comp5 = Company.create(simple_name: "Empresa V", long_name: "Empresa V Ltda.", cnpj: "01.302.458/0001-68", category: 2, address: "lala",  group: 1)
comp6 = Company.create(simple_name: "Empresa VI", long_name: "Empresa VI Ltda.", cnpj: "47.461.434/0001-52", category: 3, address: "lala",  group: 2)

email1 = Email.create(recipients_array: 'ftquixada@gmail.com', value: 0.01, day_of_month: '3', company_id: comp1.id, body: 'Prezados, até.', email_configuration_id: conf.id)
email2 = Email.create(recipients_array: 'ftquixada@gmail.com', value: 0.00, day_of_month: '28', company_id: comp2.id, body: 'Prezados, até.', email_configuration_id: conf.id)
email3 = Email.create(recipients_array: 'ftquixada@gmail.com', value: 12.33, day_of_month: '15', company_id: comp3.id, body: 'Prezados, até.', email_configuration_id: conf.id)
email4 = Email.create(recipients_array: 'ftquixada@gmail.com', value: 10000.00, day_of_month: '4', company_id: comp4.id, body: 'Prezados, até.', email_configuration_id: conf.id)
email5 = Email.create(recipients_array: 'ftquixada@gmail.com', value: 333.33, day_of_month: '18', company_id: comp4.id, body: 'Prezados, até.', email_configuration_id: conf.id, active: false)
email6 = Email.create(recipients_array: 'ftquixada@gmail.com', value: 114.88, day_of_month: '21', company_id: comp5.id, body: 'Prezados, até.', email_configuration_id: conf.id)
email7 = Email.create(recipients_array: 'ftquixada@gmail.com', value: 1743.00, day_of_month: '7', company_id: comp6.id, body: 'Prezados, até.', email_configuration_id: conf.id, active: false)