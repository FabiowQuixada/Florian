    require 'test_helper'

    class StatusTest < Capybara::Rails::TestCase

       DATA = [Role, User, Email]

        test "[Admin] change models' status" do

           visit root_path

           email = 'ftquixada@gmail.com'

            fill_in 'E-mail', :with => email
            fill_in 'Senha', :with => 'fulano0123'
            check 'Manter-me logado'

            click_on 'Login'

            DATA.each do |data|

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

                assert_content page, "sucesso"

           end
     end

     test "change models' status" do

           visit root_path

           email = 'fquixada@yahoo.com.br'

            fill_in 'E-mail', :with => email
            fill_in 'Senha', :with => 'senha_renata'
            check 'Manter-me logado'

            click_on 'Login'

            DATA.each do |data|

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
                  #assert_content page, "sucesso"
                else
                  assert_content page, "sucesso"
                end
           end
     end
end
