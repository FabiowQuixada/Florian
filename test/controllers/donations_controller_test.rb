require "test_helper"

class DonationsControllerTest < Capybara::Rails::TestCase

  test "add donation to company through new donation screen" do

            visit root_path

            fill_in 'E-mail', :with => 'ftquixada@gmail.com'
            fill_in 'Senha', :with => 'fulano0123'
            check 'Manter-me logado'

            click_on 'Login'

            visit new_donation_path

            fill_in 'Data', :with => '01/10/2015'
            fill_in 'Valor', :with => '1234'
            select(Company.first.trading_name, :from => 'donation_company_id')

            click_on 'Salvar'

            assert_content page, "sucesso"
      end

      test "add donation and prepare to add another" do

            visit root_path

            fill_in 'E-mail', :with => 'ftquixada@gmail.com'
            fill_in 'Senha', :with => 'fulano0123'
            check 'Manter-me logado'

            click_on 'Login'

            visit new_donation_path

            fill_in 'Data', :with => '01/10/2015'
            fill_in 'Valor', :with => '1234'
            select(Company.first.trading_name, :from => 'donation_company_id')

            click_on 'Salvar e cadastrar nova'

            assert_content page, "sucesso"
      end

      test "add donation to company through company screen" do

            visit root_path

            fill_in 'E-mail', :with => 'ftquixada@gmail.com'
            fill_in 'Senha', :with => 'fulano0123'
            check 'Manter-me logado'

            click_on 'Login'

            visit edit_company_path Company.first.id

            remark = 'observacao ' + Time.new.usec.to_s

            within all('.transient_donation').last do
              find('.donation_date').set '01/10/2015'
              find('.donation_value').set '5678'
              find('.donation_remark').set remark
            end

            click_on 'Nova doação'
            click_on 'Salvar'

            visit edit_company_path Company.first.id

            # within all('.persisted_donation').last do
              # find('.donation_date').set '01/10/2015'
              # find('.donation_value').set '5678'
              assert_content page, remark
          # end
      end

end
