
role1 = Role.create({name: "Admin", description: 'Administrador'})
role2 = Role.create({name: "Usuário", description: 'Usuário comum'})
role3 = Role.create({name: "Administração", description: 'Presidência'})
role4 = Role.create({name: "Secretária 1", description: '(Renata)'})
role5 = Role.create({name: "Secretária 2", description: '(Lucivania)'})

user1 = User.create({name: "Sistema",     email: SYSTEM_EMAIL, password: "fulano0123", password_confirmation: "fulano0123", bcc: 'teste@test.com', signature: '(Assinatura)', role: role1})
user2 = User.create({name: "Fabiow",      email: ADMIN_EMAIL, password: "fulano0123", password_confirmation: "fulano0123", bcc: 'ftquixada@gmail.com', signature: '(Assinatura)', role: role1})
user3 = User.create({name: "Inativo",       email: "teste_inativo@yahoo.com.br", password: "usuario_teste", password_confirmation: "usuario_teste", bcc: 'teste@test.com', signature: '(Assinatura)', role: role2, active: false})
user4 = User.create({name: "Edmar",       email: "edmarmaciel@gmail.com", password: "35348456456", password_confirmation: "35348456456", bcc: 'edmarmaciel@gmail.com', signature: '(Assinatura)', role: role3})
user5 = User.create({name: "Márcia",       email: "marciattm@hotmail.com", password: "34578933", password_confirmation: "34578933", bcc: 'marciattm@hotmail.com', signature: '(Assinatura)', role: role3})
user6 = User.create({name: "Renata",       email: "renata.sbq@gmail.com", password: "4453566486", password_confirmation: "4453566486", bcc: 'renata.sbq@gmail.com', signature: '(Assinatura)', role: role4})
user7 = User.create({name: "Lucivânia",   email: "lucivania_nojosa@hotmail.com", password: "98574325298", password_confirmation: "98574325298", bcc: 'lucivania_nojosa@hotmail.com', signature: '(Assinatura)', role: role5})

case Rails.env
    when "development" then
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

    when 'production' then
        ExcelParser.parse
end