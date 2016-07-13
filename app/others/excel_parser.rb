# rubocop:disable all
class ExcelParser
  def self.parse

    inconsistent_companies = []

    parse Roo::Excel.new(Rails.root.join('app', 'assets', 'empresas_2016.xls'))

    print_parse_errors inconsistent_companies

    inconsistent_companies
  end

  def parse(file)
    file.worksheets.each do |sheet|
      # Get companies
      (4..(sheet.count - 1)).each do |r|
        row = sheet.rows[r]

        company = parse_company row

        inconsistent_companies << company unless company.save
      end # Row loop end
    end # Sheet loop end
  end

  def print_parse_errors(inconsistent_companies)
    inconsistent_companies.each do |company|
      puts company

      company.errors.full_messages.each do |error_message|
        puts error_message
      end
    end
  end

  def self.parse_company(row)

    company = Company.new group: 1

    parse_basic_info company, col = 0
    parse_general_info company, row, col
    parse_category company, row[col += 1]
    parse_cpf_cnpj company, row[col += 1]
    parse_general_info company, row, col
    parse_contacts company
    parse_donation company, row[col += 1]
    parse_payment_frequency company, row[col += 1]
    parse_payment_period(company, row[col += 1])
    company.first_parcel = row[col += 1]
    parse_contract company, row[col + 1]

    company
  end

  def parse_cpf_cnpj(company, val)
    if company.person?
      company.cpf = val
    else
      company.cnpj = val
    end
  end

  def parse_contract(company, val)
    if val == 'Contrato'
      company.contract = Company.contracts[:"Com contrato"]
    elsif val == 'Sem contrato'
      company.contract = Company.contracts[:"Sem contrato"]
    end
  end

  def parse_donation(_company, val)
    donation = Donation.new

    if val.is_a? Numeric
      donation.value = val
    else
      donation.remark = val
    end
  end

  def parse_basic_info(company, row, col)
    company.entity_type = if row[col] == 'PF'
                            Company.entity_types[:"Pessoa Física"]
                          else
                            Company.entity_types[:"Pessoa Jurídica"]
                          end


    company.registration_name = row[col += 1]
    company.name = row[col + 1]
  end

  def parse_contacts(company)
    company.contacts.clear
    parse_contact(company, 0, 12)
    parse_contact(company, 1, 18)
    parse_contact(company, 2, 24)
  end

  def parse_contact(company, type, col)

    contact = Contact.new

    contact.name = row[col += 1]
    contact.position = row[col += 1]
    contact.position = 'Secretária' if type == 1
    contact.position = 'Setor financeiro' if type == 2
    col += 1
    contact.telephone = '85' + row[col].to_s unless row[col].nil?
    col += 1
    contact.fax = '85' + row[col].to_s unless row[col].nil?
    col += 1
    contact.celphone = '85' + row[col].to_s unless row[col].nil?
    contact.email_address = row[col + 1]
    contact.contact_type = type

    company.contacts.push contact

  end

  def parse_general_info(company, col)
    company.address = row[col += 1]
    company.neighborhood = row[col += 1]
    company.cep = row[col += 1]
    company.city = row[col += 1]
    company.state = row[col += 1]
    company.email_address = row[col += 1]
    company.website = row[col + 1]
  end

  def parse_payment_frequency(company, val)
    if val == 'Mensal'
      company.payment_frequency = Company.payment_frequencies[:Mensal]
    elsif val == 'Diariamente'
      company.payment_frequency = Company.payment_frequencies[:"Diário"]
    elsif val == 'Bimestral'
      company.payment_frequency = Company.payment_frequencies[:Bimestral]
    elsif val == 'Semanal'
      company.payment_frequency = Company.payment_frequencies[:Semanal]
    elsif val == 'Indeterminado'
      company.payment_frequency = Company.payment_frequencies[:Indeterminado]
    elsif val == 'Anual'
      company.payment_frequency = Company.payment_frequencies[:Anual]
    elsif val == 'Semestral'
      company.payment_frequency = Company.payment_frequencies[:Semestral]
    end
  end

  def parse_payment_period(company, val)
    if val == 'Indeterminado'
      company.payment_period = 0
    elsif val.is_a? Numeric
      company.payment_period = val
    end
  end

  def parse_category(company, val)
    cat = 0

    if val == 'I'
      cat = Company.categories[:"1 (Abaixo de R$ 300,00)"]
    elsif val == 'II'
      cat = Company.categories[:"2 (Entre R$ 300,00 e R$ 600,00)"]
    elsif val == 'III'
      cat = Company.categories[:"3 (Acima de R$ 600,00)"]
    end

    company.category = cat
  end
end
# rubocop:enable all