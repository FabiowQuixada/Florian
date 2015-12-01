    require 'test_helper'

    class GeneralStatusTest < Capybara::Rails::TestCase

       # include Devise::TestHelpers
        DATA = [{controller: RolesController.new, new_model: Role.new}]#,
         #{controller: UsersController.new, new_model: User.new},
         #{controller: CompaniesController.new, new_model: Company.new},
         #{controller: EmailsController.new, new_model: Email.new}
     #]


    def setup

        # a = Role.create({name: "Admin", description: 'Administrador'})
        # DATA.first[:persistent_model] = a
        # a.save!

        # @role = Role.where(:name => 'Admin')


        # @request.env["devise.mapping"] = Devise.mappings[:user]
        # sign_in FactoryGirl.create(:user, :name => "Fabiow4", :role => a)
      end

      test "login" do

            visit root_path

            fill_in 'E-mail', :with => 'ftquixada@gmail.com'
            fill_in 'Senha', :with => 'fulano0123'
            check 'Manter-me logado'

           click_on('Login')

           #save_and_open_page
            page.must_have_content('sucesso')

            visit emails_path

            sleep(inspection_time=10)
      end

      test "models activation" do

        #DATA.each do |data|

            #@controller = data[:controller]

           #page.execute_script("$('#global_error_box').attr('style', '')")

            # post :activate, {id: data[:persistent_model].id}

            # result = JSON.parse(@response.body)
            # assert result['message'].include? "sucesso"
         #end
      end

#     feature "as a student I want a working blog so people can post", :js => true do
#   scenario "User can make a post" do

#     visit emails_path
#     click_on "Novo"

#   end
# end

        test "models deactivation" do

            DATA.each do |data|

                # @controller = data[:controller]
                # post :inactivate, {id: data[:persistent_model].id}

                # result = JSON.parse(@response.body)
                # assert result['message'].include? "com sucesso!"
             end
        end

    end
