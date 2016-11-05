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
    inconsistent_maintainers = parse_file Roo::Excel.new(Rails.root.join('app', 'assets', 'empresas_2016.xls'))
    print_parse_errors inconsistent_maintainers
    inconsistent_maintainers
  end

  def self.parse_file(file)
    inconsistent_maintainers = []

    file.worksheets.each do |sheet|
      # Get maintainers
      (4..(sheet.count - 1)).each do |r|
        row = sheet.rows[r]

        maintainer = parse_maintainer row

        inconsistent_maintainers << maintainer unless maintainer.save
      end # Row loop end
    end # Sheet loop end

    inconsistent_maintainers
  end

  def self.print_parse_errors(inconsistent_maintainers)
    inconsistent_maintainers.each do |maintainer|
      maintainer.errors.full_messages.each do |error_message|
        puts error_message
      end
    end
  end

  def self.parse_maintainer(row)
    maintainer = Maintainer.new group: 1

    parse_basic_info maintainer, row
    parse_general_info maintainer, row
    parse_category maintainer, row
    parse_cpf_cnpj maintainer, row
    parse_general_info maintainer, row
    # parse_contacts maintainer, row
    # parse_donation maintainer, row
    parse_payment_frequency maintainer, row
    parse_payment_period maintainer, row
    parse_first_parcel maintainer, row
    parse_contract maintainer, row

    maintainer
  end

  def self.parse_basic_info(maintainer, row)
    col = BASIC_INFO_POS
    maintainer.entity_type = if row[col] == 'PF'
                               'person'
                             else
                               'company'
                             end

    maintainer.registration_name = row[col += 1]
    maintainer.name = row[col + 1]

    maintainer
  end

  def self.parse_general_info(maintainer, row)
    col = GENERAL_INFO_POS
    maintainer.address = row[col += 1]
    maintainer.neighborhood = row[col += 1]
    maintainer.cep = row[col += 1]
    maintainer.city = row[col += 1]
    maintainer.state = row[col += 1]
    maintainer.email_address = row[col += 1]
    maintainer.website = row[col + 1]

    maintainer
  end

  def self.parse_category(maintainer, row)
    val = row[CATEGORY_POS]
    cat = 0

    if val == 'I'
      cat = 'low'
    elsif val == 'II'
      cat = 'medium'
    elsif val == 'III'
      cat = 'high'
    end

    maintainer.category = cat

    maintainer
  end

  def self.parse_cpf_cnpj(maintainer, row)
    val = row[CPF_CNPJ_POS]
    if maintainer.person?
      maintainer.cpf = val
    else
      maintainer.cnpj = val
    end

    maintainer
  end

  def self.parse_contacts(maintainer, row)
    maintainer.contacts.clear
    parse_contact maintainer, 0, row
    parse_contact maintainer, 1, row
    parse_contact maintainer, 2, row

    maintainer
  end

  def self.parse_contact(maintainer, type, row)
    col = CONTACTS_POS + CONTACT_LEN * type
    contact = Contact.new

    contact.name = row[col += 1]
    contact.position = row[col += 1]
    col += 1
    contact.telephone = "85#{row[col]}" unless row[col].nil?
    col += 1
    contact.fax = "85#{row[col]}" unless row[col].nil?
    col += 1
    contact.celphone = "85#{row[col]}" unless row[col].nil?
    contact.email_address = row[col + 1]

    maintainer.contacts.push contact

    maintainer
  end

  def self.parse_payment_frequency(maintainer, row)
    maintainer.payment_frequency = case row[PAY_FREQ_POS]
                                   when 'Mensal'
                                     'monthly'
                                   when 'Diariamente'
                                     'diary'
                                   when 'Bimestral'
                                     'bimonthly'
                                   when 'Semanal'
                                     'weekly'
                                   when 'Indeterminado'
                                     'undefined'
                                   when 'Anual'
                                     'annually'
                                   when 'Semestral'
                                     'semiannually'
                                   end

    maintainer
  end

  def self.parse_payment_period(maintainer, row)
    val = row[PAY_PERIOD_POS]

    if val == 'Indeterminado'
      maintainer.payment_period = 0
    elsif val.is_a? Numeric
      maintainer.payment_period = val
    end

    maintainer
  end

  def self.parse_contract(maintainer, row)
    maintainer.contract = case row[CONTRACT_POS]
                          when 'Contrato'
                            'with_contract'
                          when 'Sem contrato'
                            'no_contract'
                          end

    maintainer
  end

  def self.parse_first_parcel(maintainer, row)
    val = row[FIRST_PARCEL_POS]
    maintainer.first_parcel = val

    maintainer
  end

  def read(row, col)
  end

end
