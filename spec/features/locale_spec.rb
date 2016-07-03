require 'rails_helper'

describe 'Locale', type: :request do
  DATA = [Company, Donation, ReceiptEmail, ProductAndServiceDatum, User, Role].freeze

  it 'contains no translation missing' do
    login_as_admin

    DATA.each do |data|
      begin

            @model = data.new

            visit send(@model.model_name.route_key + '_path')

            expect(page).to have_no_content('translation_missing'), data

            visit send('new_' + @model.class.name.singularize.underscore + '_path')

            if @model.insertable
              click_on 'Salvar'

              expect(page).to have_no_content('translation_missing'), data

           end

          rescue Capybara::ElementNotFound => e

            raise Capybara::ElementNotFound, e.message + ': ' + data.name
          end
    end
  end
end
