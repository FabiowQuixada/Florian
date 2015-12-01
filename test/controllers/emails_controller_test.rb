require 'test_helper'

class EmailsControllerTest < Capybara::Rails::TestCase

        test "resend e-mail though listing page" do

            visit root_path

            fill_in 'E-mail', :with => 'ftquixada@gmail.com'
            fill_in 'Senha', :with => 'fulano0123'
            check 'Manter-me logado'

           click_on 'Login'

            page.must_have_content('sucesso')

            visit emails_path

            all(".resend_btn").first.click()
            fill_in 'resend_competence', :with => '10/2015'
            click_on 'Enviar'

            assert_content page, "sucesso"
      end

      test "resend e-mail though update page" do

            visit root_path

            fill_in 'E-mail', :with => 'ftquixada@gmail.com'
            fill_in 'Senha', :with => 'fulano0123'
            check 'Manter-me logado'

           click_on('Login')

            page.must_have_content('sucesso')

            visit edit_email_path Email.first.id

            all(".resend_btn").first.click()
            fill_in 'resend_competence', :with => '10/2015'
            click_on 'Enviar'

            assert_content page, "sucesso"
      end

      test "send test e-mail though listing page" do

            visit root_path

            fill_in 'E-mail', :with => 'ftquixada@gmail.com'
            fill_in 'Senha', :with => 'fulano0123'
            check 'Manter-me logado'

           click_on('Login')

            page.must_have_content('sucesso')

            visit emails_path

            all(".send_test_btn").first.click()
            fill_in 'send_test_competence', :with => '10/2015'
            click_on 'Enviar'

            assert_content page, "sucesso"
      end

      test "send test e-mail though update page" do

            visit root_path

            fill_in 'E-mail', :with => 'ftquixada@gmail.com'
            fill_in 'Senha', :with => 'fulano0123'
            check 'Manter-me logado'

           click_on('Login')

            page.must_have_content('sucesso')

            visit edit_email_path Email.first.id

            all(".send_test_btn").first.click()
            fill_in 'send_test_competence', :with => '10/2015'
            click_on 'Enviar'

            assert_content page, "sucesso"
      end
end
