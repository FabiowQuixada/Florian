    require 'test_helper'

    class LocaleTest < Capybara::Rails::TestCase

     #   DATA = [Company, Donation, ReceiptEmail, ProductAndServiceEmail, User, Role]

     #    test "[Admin] change models' status" do

     #       login_as_admin

     #        DATA.each do |data|

     #              @model = data.new

     #              visit send(@model.model_name.route_key + "_path")

     #              page.should have_no_content('translation_missing')

     #              visit send("new_" + @model.class.name.singularize.underscore + "_path")

     #              click_on 'Salvar'

     #              #page.should have_no_content('translation_missing')


     #              page.should_not have_content('translation_missing')

     #       end

     # end
end
