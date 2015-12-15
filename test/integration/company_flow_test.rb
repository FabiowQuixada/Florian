require 'test_helper'

class CompanyFlowTest < Capybara::Rails::TestCase

        test "Modified donation data should display warning message when pressing back button" do

            login_as_admin

            visit edit_company_path Company.first.id

            within all('.transient_donation').last do
              find('.donation_date').set '01/10/2015'
              find('.donation_value').set '5678'
              find('.donation_remark').set 'observacao'
            end

            page.find("#form_back_btn").click

            sleep(inspection_time=2)

            assert_content page, 'Dados não salvos'

     end

    test "Modified contact data should display warning message when pressing back button" do

            login_as_admin

            visit edit_company_path Company.first.id

            within all('.contact_tab').first do
              find('.contact_name').set 'João'
              find('.contact_position').set 'Dono'
            end

            page.find("#form_back_btn").click

            sleep(inspection_time=2)

            assert_content page, 'Dados não salvos'

     end
end
