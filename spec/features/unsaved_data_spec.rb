require 'rails_helper'

describe 'Unsaved data', type: :request do
  DATA = [Company, Bill, ProductAndServiceDatum, Donation, Role, User, ReceiptEmail].freeze

  it 'displays unsaved data warning' do
    login_as_admin

    DATA.each do |data|
      begin

        @model = data.new

        visit send('edit_' + @model.class.name.singularize.underscore + '_path', data.first.id)

        all('input').each do |input|
          unless input[:readonly]
            input.set 'whatever'
            break
          end
        end

        all('textarea').each do |textarea|
          unless textarea[:readonly]
            textarea.set 'whatever'
            break
          end
        end

        all('.date input').each do |date_field|
          unless date_field[:readonly]
            date_field.set '11/11/1111'
            break
          end
        end

        all('.money').each do |money_field|
          unless money_field[:readonly]
            money_field.set '0,01'
            break
          end
        end

        page.find('#form_back_btn').click

        sleep(inspection_time = 0.5)

        expect(page).to have_content('Dados não salvos'), data.name

      rescue Capybara::ElementNotFound => e

        raise Capybara::ElementNotFound, e.message + ': ' + data.name
      end
    end
  end

  it 'does not display unsaved data warning if temporary fields are filled' do
    login_as_admin

    [Company, Bill, ProductAndServiceDatum, Donation, ReceiptEmail].each do |data|
      begin

        @model = data.new

        visit send('edit_' + @model.class.name.singularize.underscore + '_path', data.first.id)

        page.find('#main_tab_1_title').click if @model.is_a? Company

        # byebug if @model.is_a? ProductAndServiceDatum

        unless all('.temp_field').empty?
          all('.temp_field').each do |input|
            input.set 'whatever'
          end

          page.find('#form_back_btn').click

          sleep(inspection_time = 1)

          expect(page).to have_no_content('Dados não salvos'), data.name
        end
      rescue Capybara::ElementNotFound => e
        raise Capybara::ElementNotFound, e.message + ': ' + data.name
      end
    end
  end
end
