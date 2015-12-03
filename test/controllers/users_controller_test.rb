require 'test_helper'

class EmailsControllerTest < Capybara::Rails::TestCase

        test "inactive user should not login" do

            visit root_path

            fill_in 'E-mail', :with => 'teste_inativo@yahoo.com.br'
            fill_in 'Senha', :with => 'usuario_teste'
            check 'Manter-me logado'

            click_on 'Login'

            assert_content page, "inativada"

      end
end
