
if Rails.env == 'showcase'
  guest_role = Role.create(name: SHOWCASE_USER, description: SHOWCASE_USER)

  GUEST_USERS_NUMBERS.each do |number|
    User.create name: Faker::Name.name,
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

  User.create(name: 'Sistema',     email: SYSTEM_EMAIL, password: 'fulano0123', password_confirmation: 'fulano0123', role: role1)
  User.create(name: 'Fabiow',      email: ADMIN_EMAIL, password: 'fulano0123', password_confirmation: 'fulano0123', role: role1)
  User.create(name: 'Inativo', email: 'teste_inativo@yahoo.com.br', password: 'usuario_teste', password_confirmation: 'usuario_teste', role: role2, active: false)
  User.create(name: 'Comum', email: 'teste_comum@yahoo.com.br', password: 'usuario_comum', password_confirmation: 'usuario_comum', role: role2)
  User.create(name: 'Edmar', email: 'edmarmaciel@gmail.com', password: '35348456456', password_confirmation: '35348456456', role: role3)
  User.create(name: "Márcia",       email: 'marciattm@hotmail.com', password: '34578933', password_confirmation: '34578933', role: role3)
  User.create(name: 'Renata',       email: 'renata.sbq@gmail.com', password: '4453566486', password_confirmation: '4453566486', role: role4)
  User.create(name: "Lucivânia", email: 'lucivania_nojosa@hotmail.com', password: '98574325298', password_confirmation: '98574325298', role: role5)
end


case Rails.env
when 'development', 'test', 'showcase' then
  comp1 = Maintainer.create entity_type: :company, name: Faker::Company.name.to_s, registration_name: Faker::Company.name.to_s, cnpj: '31162488000187', category: :medium, address: Faker::Address.street_address, group: :maintainer
  comp2 = Maintainer.create entity_type: :company, name: Faker::Company.name.to_s, registration_name: Faker::Company.name.to_s, cnpj: '34.781.467/0001-38', category: :medium, address: Faker::Address.street_address, group: :maintainer
  comp3 = Maintainer.create entity_type: :company, name: Faker::Company.name.to_s, registration_name: Faker::Company.name.to_s, cnpj: '01.476.667/0001-28', category: :low, address: Faker::Address.street_address, group: :maintainer
  comp4 = Maintainer.create entity_type: :company, name: Faker::Company.name.to_s, registration_name: Faker::Company.name.to_s, cnpj: '46.426.366/0001-28', category: :medium, address: Faker::Address.street_address, group: :maintainer
  comp5 = Maintainer.create entity_type: :company, name: Faker::Company.name.to_s, registration_name: Faker::Company.name.to_s, cnpj: '01.302.458/0001-68', category: :medium, address: Faker::Address.street_address, group: :maintainer
  comp6 = Maintainer.create entity_type: :person, name: Faker::Name.name, registration_name: Faker::Name.name, cpf: '377.417.213-72', category: :low, address: Faker::Address.street_address, group: :maintainer

  Donation.create(value: 0.00, donation_date: Time.now, remark: '02 potes de creme', maintainer: comp1)
  Donation.create(donation_date: Time.now, remark: '02 potes de creme', maintainer: comp1)
  Donation.create(value: 220.00, donation_date: Time.now, remark: '', maintainer: comp1)
  Donation.create(value: 0.96, donation_date: Time.now, remark: '', maintainer: comp2)
  Donation.create(value: 70.00, donation_date: Time.now, remark: '', maintainer: comp2)

  ReceiptEmail.create recipients_array: 'betelguese@gmail.com', value: 0.01, day_of_month: '3', maintainer_id: comp1.id, body: "Dear all, \n\nhere is the receipt with respect to #competence.\n\nRegards,"
  ReceiptEmail.create recipients_array: 'mintaka@gmail.com', value: 0.00, day_of_month: '28', maintainer_id: comp2.id, body: "Dear all, \n\nhere is the receipt with respect to #competence.\n\nRegards,"
  ReceiptEmail.create recipients_array: 'shaula@gmail.com', value: 12.33, day_of_month: '15', maintainer_id: comp3.id, body: "Dear all, \n\nhere is the receipt with respect to #competence.\n\nRegards,"
  ReceiptEmail.create recipients_array: 'regulus@gmail.com', value: 10_000.00, day_of_month: '4', maintainer_id: comp4.id, body: "Dear all, \n\nhere is the receipt with respect to #competence.\n\nRegards,"
  ReceiptEmail.create recipients_array: 'polaris@gmail.com', value: 333.33, day_of_month: '18', maintainer_id: comp4.id, body: "Dear all, \n\nhere is the receipt with respect to #competence.\n\nRegards,", active: false
  ReceiptEmail.create recipients_array: 'aldebaran@gmail.com', value: 114.88, day_of_month: '21', maintainer_id: comp5.id, body: "Dear all, \n\nhere is the receipt with respect to #competence.\n\nRegards,"
  ReceiptEmail.create recipients_array: 'benetnash@gmail.com', value: 1743.00, day_of_month: '7', maintainer_id: comp6.id, body: "Dear all, \n\nhere is the receipt with respect to #competence.\n\nRegards,", active: false

  (0..6).each do |m|
    ProductAndServiceDatum.create competence: Date.today - m.month
  end

  (0..50).each do |m|
    Bill.create(
      competence: Date.today - m.months,
      water: rand(90..200),
      telephone: rand(90..200),
      energy: rand(90..200)
    )
  end

when 'production' then
  ExcelParser.parse
end
