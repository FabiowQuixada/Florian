# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

role1 = Role.create({name: "Admin", description: 'Administrador'})
role2 = Role.create({name: "Usuário", description: 'Usuário comum'})

user1 = User.create({name: "Sistema", email: "apoioaoqueimado@yahoo.com.br", password: "fulano0123", password_confirmation: "fulano0123", bcc: 'teste@test.com', signature: 'teste', role: role1})
user2 = User.create({name: "Fabiow", email: "ftquixada@gmail.com", password: "fulano0123", password_confirmation: "fulano0123", bcc: 'teste@test.com', signature: 'teste', role: role1})
user3 = User.create({name: "Lucivânia", email: "luci@yahoo.com.br", password: "senha_renata", password_confirmation: "senha_renata", bcc: 'teste@test.com', signature: 'teste', role: role2})
user3 = User.create({name: "Renata", email: "fquixada@yahoo.com.br", password: "senha_renata", password_confirmation: "senha_renata", bcc: 'teste@test.com', signature: 'teste', role: role2})
user3 = User.create({name: "Usuário Inativo", email: "teste_inativo@yahoo.com.br", password: "usuario_teste", password_confirmation: "usuario_teste", bcc: 'teste@test.com', signature: 'teste', role: role2, active: false})

comp1 = Company.create(trading_name: "Empresa I", name: "Empresa I Ltda.", cnpj: "31162488000187", category: 1, address: "lala", group: 1)
comp2 = Company.create(trading_name: "Empresa II", name: "Empresa II Ltda.", cnpj: "34.781.467/0001-38", category: 2, address: "lala",  group: 2)
comp3 = Company.create(trading_name: "Empresa III", name: "Empresa III Ltda.", cnpj: "01.476.667/0001-28", category: 3, address: "lala",  group: 3)
comp4 = Company.create(trading_name: "Empresa IV", name: "Empresa IV Ltda.", cnpj: "46.426.366/0001-28", category: 1, address: "lala",  group: 3)
comp5 = Company.create(trading_name: "Empresa V", name: "Empresa V Ltda.", cnpj: "01.302.458/0001-68", category: 2, address: "lala",  group: 1)
comp6 = Company.create(trading_name: "Empresa VI", name: "Empresa VI Ltda.", cnpj: "47.461.434/0001-52", category: 3, address: "lala",  group: 2)

don1 = Donation.create(value: 0.00, donation_date: Time.now, remark: "02 potes de creme", company: comp1)
don2 = Donation.create(donation_date: Time.now, remark: "02 potes de creme", company: comp1)
don3 = Donation.create(value: 220.00, donation_date: Time.now, remark: "", company: comp1)
don4 = Donation.create(value: 0.96, donation_date: Time.now, remark: "", company: comp2)
don5 = Donation.create(value: 70.00, donation_date: Time.now, remark: "", company: comp2)

email1 = ReceiptEmail.create(recipients_array: 'ftquixada@gmail.com', value: 0.01, day_of_month: '3', company_id: comp1.id, body: 'Prezados, até.')
email2 = ReceiptEmail.create(recipients_array: 'ftquixada@gmail.com', value: 0.00, day_of_month: '28', company_id: comp2.id, body: 'Prezados, até.')
email3 = ReceiptEmail.create(recipients_array: 'ftquixada@gmail.com', value: 12.33, day_of_month: '15', company_id: comp3.id, body: 'Prezados, até.')
email4 = ReceiptEmail.create(recipients_array: 'ftquixada@gmail.com', value: 10000.00, day_of_month: '4', company_id: comp4.id, body: 'Prezados, até.')
email5 = ReceiptEmail.create(recipients_array: 'ftquixada@gmail.com', value: 333.33, day_of_month: '18', company_id: comp4.id, body: 'Prezados, até.', active: false)
email6 = ReceiptEmail.create(recipients_array: 'ftquixada@gmail.com', value: 114.88, day_of_month: '21', company_id: comp5.id, body: 'Prezados, até.')
email7 = ReceiptEmail.create(recipients_array: 'ftquixada@gmail.com', value: 1743.00, day_of_month: '7', company_id: comp6.id, body: 'Prezados, até.', active: false)