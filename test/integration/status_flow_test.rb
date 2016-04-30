    require 'test_helper'

    class StatusFlowTest < Capybara::Rails::TestCase

      # def initialize(num)
      #   ActiveRecord::Base.connection.tables.map do |model|
      #     klass = model.capitalize.singularize.camelize
      #     if klass != "SchemaMigration" and klass != "Audit" and Object.const_get(klass).column_names.include? 'active'
      #       puts klass
      #     end
      #   end
      # end

       DATA = [Role, User, ReceiptEmail]

        test "[Admin] change models' status" do

           visit root_path

           email = 'ftquixada@gmail.com'

            fill_in 'E-mail', :with => email
            fill_in 'Senha', :with => 'fulano0123'
            check 'Manter-me logado'

            click_on 'Login'

            DATA.each do |data|

              begin

                  @model = data.new

                  visit send(@model.model_name.route_key + "_path")

                  if page.has_css?('.model_row')

                    if @model.is_a? User

                      page.all('.model_row').each do |row|

                        if row.find('.user_email').text != email
                          row.find('.status_btn').click
                          break
                        end
                      end
                    else
                      all('.model_row').first.all('.status_btn')[0].click
                    end
                end

                assert page.has_content?("sucesso"), ('Expected to include "sucesso": ' + data.to_s)

               rescue Capybara::ElementNotFound => e

                  raise Capybara::ElementNotFound, e.message + ': ' + data.name
                 end

           end
     end

     test "change models' status" do

           login_as_common_user

            DATA.each do |data|

              begin

                 @model = data.new

                  visit send(@model.model_name.route_key + "_path")

                  if page.has_css?('.model_row')

                    if @model.is_a? User

                      page.all('.model_row').each do |row|

                        if row.find('.user_email').text != email
                          row.find('.status_btn').click
                          break
                        end
                      end
                    else
                      all('.model_row').first.all('.status_btn')[0].click
                    end
                end

                if @model.is_a? User or @model.is_a? Role
                  assert_content page, "negado"
                else
                  assert page.has_content?("sucesso"), ('Expected to include "sucesso": ' + data.to_s)
                end

                rescue Capybara::ElementNotFound => e

                  raise Capybara::ElementNotFound, e.message + ': ' + data.name
                 end
           end
     end
end
