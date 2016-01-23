require 'test_helper'

class CompanyTest < ActiveSupport::TestCase

    test 'should save company the with the minimum required fields' do

        company = Company.new

        company.trading_name = 'Exemplo'
        company.name = 'Exemplo2'
        company.cnpj = '60.712.334/0001-10'
        company.address = 'Aqui'
        company.category = 1
        company.group = 1

        assert company.save, company.errors

    end

    test 'company should have default contacts' do

        company = Company.new

        assert company.contacts.length == 3

    end

end
