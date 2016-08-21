# rubocop:disable all
class ExcelParser

  CPF_CNPJ_POS = 4
  CONTACTS_POS = 12
  CONTACT_LEN = 6
  CATEGORY_POS = 3
  GENERAL_INFO_POS = 4
  BASIC_INFO_POS = 0
  PAY_FREQ_POS = 29
  PAY_PERIOD_POS = 30
  FIRST_PARCEL_POS = 31
  CONTRACT_POS = 32

  def self.parse

    inconsistent_companies = parse_file Roo::Excel.new(Rails.root.join('app', 'assets', 'empresas_2016.xls'))

    print_parse_errors inconsistent_companies

    inconsistent_companies
  end

  def self.parse_file(file)
    
    inconsistent_companies = []

    file.worksheets.each do |sheet|
      # Get companies
      (4..(sheet.count - 1)).each do |r|
        row = sheet.rows[r]

        company = parse_company row

        inconsistent_companies << company unless company.save
      end # Row loop end
    end # Sheet loop end

    inconsistent_companies
  end

  def self.print_parse_errors(inconsistent_companies)
    inconsistent_companies.each do |company|
      # puts company


      company.errors.full_messages.each do |error_message|
        puts error_message
      end
    end
  end

  def self.parse_company(row)

    company = Company.new group: 1

    parse_basic_info company, row
    parse_general_info company, row
    parse_category company, row
    parse_cpf_cnpj company, row
    parse_general_info company, row
    # parse_contacts company, row
    # parse_donation company, row
    parse_payment_frequency company, row
    parse_payment_period company, row
    parse_first_parcel = company, row
    parse_contract company, row

    company
  end

  def self.parse_basic_info(company, row)

    col = BASIC_INFO_POS
    company.entity_type = if row[col] == 'PF'
                            Company.entity_types[:"Pessoa Física"]
                          else
                            Company.entity_types[:"Pessoa Jurídica"]
                          end


    company.registration_name = row[col += 1]
    company.name = row[col + 1]

    company
  end

  def self.parse_general_info(company, row)

    col = GENERAL_INFO_POS
    company.address = row[col += 1]
    company.neighborhood = row[col += 1]
    company.cep = row[col += 1]
    company.city = row[col += 1]
    company.state = row[col += 1]
    company.email_address = row[col += 1]
    company.website = row[col + 1]

    company
  end


  def self.parse_category(company, row)

    val = row[CATEGORY_POS]
    cat = 0

    if val == 'I'
      cat = Company.categories[:"1 (Abaixo de R$ 300,00)"]
    elsif val == 'II'
      cat = Company.categories[:"2 (Entre R$ 300,00 e R$ 600,00)"]
    elsif val == 'III'
      cat = Company.categories[:"3 (Acima de R$ 600,00)"]
    end

    company.category = cat

    company
  end

  def self.parse_cpf_cnpj(company, row)

    val = row[CPF_CNPJ_POS]
    if company.person?
      company.cpf = val
    else
      company.cnpj = val
    end

    company
  end

  def self.parse_contacts(company, row)
    company.contacts.clear

    parse_contact company, 0, row
    parse_contact company, 1, row
    parse_contact company, 2, row

    company
  end

  def self.parse_contact(company, type, row)

    col = CONTACTS_POS + CONTACT_LEN * type

    contact = Contact.new

    contact.name = row[col += 1]
    contact.position = row[col += 1]
    col += 1
    contact.telephone = '85' + row[col].to_s unless row[col].nil?
    col += 1
    contact.fax = '85' + row[col].to_s unless row[col].nil?
    col += 1
    contact.celphone = '85' + row[col].to_s unless row[col].nil?
    contact.email_address = row[col + 1]

    company.contacts.push contact

    company
  end

  def self.parse_payment_frequency(company, row)

    val = row[PAY_FREQ_POS]
  
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

    company
  end

  def self.parse_payment_period(company, row)

    val = row[PAY_PERIOD_POS]

    if val == 'Indeterminado'
      company.payment_period = 0
    elsif val.is_a? Numeric
      company.payment_period = val
    end

    company
  end

  def self.parse_contract(company, row)

    val = row[CONTRACT_POS]
    if val == 'Contrato'
      company.contract = Company.contracts[:"Com contrato"]
    elsif val == 'Sem contrato'
      company.contract = Company.contracts[:"Sem contrato"]
    end

    company
  end

  def self.parse_first_parcel(company, row)
      val = row[FIRST_PARCEL_POS]
      company.first_parcel = val

    company
  end

end
# rubocop:enable all