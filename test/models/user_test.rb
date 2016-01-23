require 'test_helper'

class UserTest < ActiveSupport::TestCase

    test 'should save system setting automatically' do

        role = Role.create({name: "Secretária 23", description: '(Lucivania)'})
        user = User.create({name: "Inativo",       email: "teste_inativo4@yahoo.com.br", password: "usuario_teste", password_confirmation: "usuario_teste", bcc: 'teste@test.com', signature: 'teste', role: role, active: false})

        assert user.system_setting.persisted?

    end

end
