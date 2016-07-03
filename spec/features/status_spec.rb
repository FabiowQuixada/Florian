require 'rails_helper'

describe 'Status', type: :request do
  # def initialize(num)
  #   ActiveRecord::Base.connection.tables.map do |model|
  #     klass = model.capitalize.singularize.camelize
  #     if klass != "SchemaMigration" and klass != "Audit" and Object.const_get(klass).column_names.include? 'active'
  #       puts klass
  #     end
  #   end
  # end

  STATUS_DATA = [Role, ReceiptEmail].freeze

  it "[Admin] change models' status" do
    login_as_admin

    STATUS_DATA.each do |data|
      begin

        @model = data.new

        visit send(@model.model_name.route_key + '_path')

        if page.has_css?('.model_row')

          if @model.is_a? User

            page.all('.model_row').each do |row|

              email = row.find('.user_email').text
              if email != SYSTEM_EMAIL && email != 'teste_comum@yahoo.com.br'
                row.find('.status_btn').click
                break
              end
            end
          else
            all('.model_row').first.all('.status_btn')[0].click
          end
        end

        expect(page).to have_content('sucesso'), ('Expected to include "sucesso": ' + data.to_s)

      rescue Capybara::ElementNotFound => e

        raise Capybara::ElementNotFound, e.message + ': ' + data.name
      end
    end
  end

  it "change models' status" do

    login_as_common_user

    [ReceiptEmail].each do |data|
      begin

        @model = data.new

        visit send(@model.model_name.route_key + '_path')

        if @model.is_a?(User) || @model.is_a?(Role)
          expect(page).to have_content('negado'), data.to_s
        end

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

        expect(page).to have_content('sucesso'), ('Expected to include "sucesso": ' + data.to_s)


      rescue Capybara::ElementNotFound => e

        raise Capybara::ElementNotFound, e.message + ': ' + data.name
      end
    end
  end
end
