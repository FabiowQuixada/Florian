require 'test_helper'

class UnsavedDataFlowTest < Capybara::Rails::TestCase

       DATA = [Company, Role, User, ReceiptEmail]

        test "Should display unsaved data warning" do

           login_as_admin

            DATA.each do |data|

              begin

                  @model = data.new

                  visit send("edit_" + @model.class.name.singularize.underscore + "_path", data.first.id)

                  all("input").each do |input|

                    if !input[:readonly]
                      input.set 'whatever'
                      break
                    end
                  end

                  page.find("#form_back_btn").click

                  sleep(inspection_time=2)

                  assert page.has_content?('Dados não salvos'), data

                rescue Capybara::ElementNotFound => e

                  raise Capybara::ElementNotFound, e.message + ': ' + data.name
                 end

           end
         end

         test "Should NOT display unsaved data warning" do

           login_as_admin

            DATA.each do |data|

              begin

                  @model = data.new

                  visit send("edit_" + @model.class.name.singularize.underscore + "_path", data.first.id)

                  all(".temp_field").each do |input|
                      input.set 'whatever'
                  end

                  page.find("#form_back_btn").click

                  sleep(inspection_time=1)

                  assert_not page.has_content?('Dados não salvos'), data
                rescue Capybara::ElementNotFound => e

                  raise Capybara::ElementNotFound, e.message + ': ' + data.name
                 end

           end
     end

end
