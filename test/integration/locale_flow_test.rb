    require 'test_helper'

    class LocaleFlowTest < Capybara::Rails::TestCase

       DATA = [Company, Donation, ReceiptEmail, ProductAndServiceDatum, User, Role]

        test "Should contain no translation missing" do

           login_as_admin

            DATA.each do |data|

                  @model = data.new

                  visit send(@model.model_name.route_key + "_path")

                  refute_content page, 'translation_missing'

                  visit send("new_" + @model.class.name.singularize.underscore + "_path")

                  if @model.insertable
                    click_on 'Salvar'

                  refute_content page, 'translation_missing'

                 end

           end

     end
end
