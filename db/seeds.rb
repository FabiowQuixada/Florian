# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

r1 = Role.create({name: "Admin", description: 'Administrador'})
r2 = Role.create({name: "Usuário", description: 'Usuário comum'})

u1 = User.create({name: "Sistema", email: "apoioaoqueimado@yahoo.com.br", password: "fulano0123", password_confirmation: "fulano0123", role: r1})
u2 = User.create({name: "Fabiow", email: "ftquixada@gmail.com", password: "fulano0123", password_confirmation: "fulano0123", role: r1})
u3 = User.create({name: "João", email: "fquixada@yahoo.com.br", password: "fulano0123", password_confirmation: "fulano0123", role: r2})

e1 = EmailConfiguration.create({signature: 'Joao', test_recipient: 'ftquixada@gmail.com'})
