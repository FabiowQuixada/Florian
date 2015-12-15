    require 'test_helper'

    class LocaleFlowTest < Capybara::Rails::TestCase

       DATA = [Company, Donation, ReceiptEmail, ProductAndServiceEmail, User, Role]

        test "Should contain no translation missing" do

           login_as_admin

            DATA.each do |data|

                  @model = data.new

                  visit send(@model.model_name.route_key + "_path")

                  #assert_no_text 'translation_missing'

                  page.must_not_have_content('translation_missing')

                 # page.should have_content()

                  visit send("new_" + @model.class.name.singularize.underscore + "_path")

                  click_on 'Salvar'

                  page.must_not_have_content('translation_missing')

              #    page.should have_content('')


               #   page.should_not have_content('translation_missing')

           end

     end
end
