require 'test_helper'

class CompanyTest < ActiveSupport::TestCase

    test 'should save company the with the minimum required fields' do

        company = Company.new

        company.entity_type = Company.entity_types[:"Pessoa Jurídica"]
        company.name = 'Exemplo'
        company.registration_name = 'Exemplo2'
        company.cnpj = '60.712.334/0001-10'
        company.address = 'Aqui'
        company.category = Company.categories[:"1 (Abaixo de R$ 300,00)"]
        company.group = Company.groups[:"Mantenedora"]

        assert company.save, company.errors.first

    end

    test 'company should have default contacts' do

        company = Company.new

        assert company.contacts.length == 3

    end

end
