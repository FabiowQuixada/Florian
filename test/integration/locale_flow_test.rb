require 'test_helper'

class LocaleFlowTest < Capybara::Rails::TestCase

  DATA = [Company, Donation, ReceiptEmail, ProductAndServiceDatum, User, Role].freeze

  test 'Should contain no translation missing' do
    login_as_admin

    DATA.each do |data|
      begin

            @model = data.new

            visit send(@model.model_name.route_key + '_path')

            assert_not page.has_content?('translation_missing'), data

            visit send('new_' + @model.class.name.singularize.underscore + '_path')

            if @model.insertable
              click_on 'Salvar'

              assert_not page.has_content?('translation_missing'), data

           end

          rescue Capybara::ElementNotFound => e

            raise Capybara::ElementNotFound, e.message + ': ' + data.name
          end
    end
  end
end
