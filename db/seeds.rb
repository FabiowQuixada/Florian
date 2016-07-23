
role1 = Role.create(name: 'Admin', description: 'Administrador')
role2 = Role.create(name: "Usuário", description: 'Usuário comum')
role3 = Role.create(name: "Administração", description: 'Presidência')
role4 = Role.create(name: "Secretária 1", description: '(Renata)')
role5 = Role.create(name: "Secretária 2", description: '(Lucivania)')

User.create(name: 'Sistema',     email: SYSTEM_EMAIL, password: 'fulano0123', password_confirmation: 'fulano0123', bcc: 'teste@test.com', signature: '(Assinatura)', role: role1)
User.create(name: 'Fabiow',      email: ADMIN_EMAIL, password: 'fulano0123', password_confirmation: 'fulano0123', bcc: 'ftquixada@gmail.com', signature: '(Assinatura)', role: role1)
User.create(name: 'Inativo', email: 'teste_inativo@yahoo.com.br', password: 'usuario_teste', password_confirmation: 'usuario_teste', bcc: 'teste@test.com', signature: '(Assinatura)', role: role2, active: false)
User.create(name: 'Comum', email: 'teste_comum@yahoo.com.br', password: 'usuario_comum', password_confirmation: 'usuario_comum', bcc: 'teste@test.com', signature: '(Assinatura)', role: role2)
User.create(name: 'Edmar', email: 'edmarmaciel@gmail.com', password: '35348456456', password_confirmation: '35348456456', bcc: 'edmarmaciel@gmail.com', signature: '(Assinatura)', role: role3)
User.create(name: "Márcia",       email: 'marciattm@hotmail.com', password: '34578933', password_confirmation: '34578933', bcc: 'marciattm@hotmail.com', signature: '(Assinatura)', role: role3)
User.create(name: 'Renata',       email: 'renata.sbq@gmail.com', password: '4453566486', password_confirmation: '4453566486', bcc: 'renata.sbq@gmail.com', signature: '(Assinatura)', role: role4)
User.create(name: "Lucivânia", email: 'lucivania_nojosa@hotmail.com', password: '98574325298', password_confirmation: '98574325298', bcc: 'lucivania_nojosa@hotmail.com', signature: '(Assinatura)', role: role5)

if Rails.env == 'showcase'
  role6 = Role.create(name: 'Visitante', description: 'Visitante')
  User.create(name: 'Visitante', email: 'visitante@florian.com', password: 'visitante', password_confirmation: 'visitante', bcc: 'visitante@florian.com', signature: 'Visitante', role: role6)
end

case Rails.env
when 'development', 'test', 'showcase' then
  comp1 = Company.create(entity_type: Company.entity_types[:"Pessoa Jurídica"], name: 'Empresa I', registration_name: 'Empresa I Ltda.', cnpj: '31162488000187', category: Company.categories[:"2 (Entre R$ 300,00 e R$ 600,00)"], address: 'lala', group: Company.groups[:Mantenedora])
  comp2 = Company.create(entity_type: Company.entity_types[:"Pessoa Jurídica"], name: 'Empresa II', registration_name: 'Empresa II Ltda.', cnpj: '34.781.467/0001-38', category: Company.categories[:"2 (Entre R$ 300,00 e R$ 600,00)"], address: 'lala',  group: Company.groups[:Mantenedora])
  comp3 = Company.create(entity_type: Company.entity_types[:"Pessoa Jurídica"], name: 'Empresa III', registration_name: 'Empresa III Ltda.', cnpj: '01.476.667/0001-28', category: Company.categories[:"1 (Abaixo de R$ 300,00)"], address: 'lala', group: Company.groups[:Mantenedora])
  comp4 = Company.create(entity_type: Company.entity_types[:"Pessoa Jurídica"], name: 'Empresa IV', registration_name: 'Empresa IV Ltda.', cnpj: '46.426.366/0001-28', category: Company.categories[:"2 (Entre R$ 300,00 e R$ 600,00)"], address: 'lala', group: Company.groups[:Mantenedora])
  comp5 = Company.create(entity_type: Company.entity_types[:"Pessoa Jurídica"], name: 'Empresa V', registration_name: 'Empresa V Ltda.', cnpj: '01.302.458/0001-68', category: Company.categories[:"2 (Entre R$ 300,00 e R$ 600,00)"], address: 'lala', group: Company.groups[:Mantenedora])
  comp6 = Company.create(entity_type: Company.entity_types[:"Pessoa Jurídica"], name: 'Empresa VI', registration_name: 'Empresa VI Ltda.', cnpj: '47.461.434/0001-52', category: Company.categories[:"1 (Abaixo de R$ 300,00)"], address: 'lala', group: Company.groups[:Mantenedora])

  Donation.create(value: 0.00, donation_date: Time.now, remark: '02 potes de creme', company: comp1)
  Donation.create(donation_date: Time.now, remark: '02 potes de creme', company: comp1)
  Donation.create(value: 220.00, donation_date: Time.now, remark: '', company: comp1)
  Donation.create(value: 0.96, donation_date: Time.now, remark: '', company: comp2)
  Donation.create(value: 70.00, donation_date: Time.now, remark: '', company: comp2)

  ReceiptEmail.create(recipients_array: 'ftquixada@gmail.com', value: 0.01, day_of_month: '3', company_id: comp1.id, body: 'Prezados, até.')
  ReceiptEmail.create(recipients_array: 'ftquixada@gmail.com', value: 0.00, day_of_month: '28', company_id: comp2.id, body: 'Prezados, até.')
  ReceiptEmail.create(recipients_array: 'ftquixada@gmail.com', value: 12.33, day_of_month: '15', company_id: comp3.id, body: 'Prezados, até.')
  ReceiptEmail.create(recipients_array: 'ftquixada@gmail.com', value: 10_000.00, day_of_month: '4', company_id: comp4.id, body: 'Prezados, até.')
  ReceiptEmail.create(recipients_array: 'ftquixada@gmail.com', value: 333.33, day_of_month: '18', company_id: comp4.id, body: 'Prezados, até.', active: false)
  ReceiptEmail.create(recipients_array: 'ftquixada@gmail.com', value: 114.88, day_of_month: '21', company_id: comp5.id, body: 'Prezados, até.')
  ReceiptEmail.create(recipients_array: 'ftquixada@gmail.com', value: 1743.00, day_of_month: '7', company_id: comp6.id, body: 'Prezados, até.', active: false)

when 'production' then
  ExcelParser.parse
end
