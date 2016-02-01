class ExcelParser
 def self.parse

         file = Roo::Excel.new(Rails.root.join('app', 'assets', 'test.xls'))

         file.worksheets.each_with_index do |sheet, index|

          # Get companies
          for r in 5..(sheet.count-1)

              row = sheet.rows[r]

              #byebug if index > 0

              #byebug if row.nil?

              company = parse_company row, (index+1)

              if !company.save
                  puts company.errors
                  #byebug if index > 0
              end
          end # Row loop end

         end # Sheet loop end
    end

    private

    def self.parse_company(row, group)

      col = 1
      company = Company.new

      company.trading_name = row[col]
      company.name = row[col]

      cat = 1#0 ##########################################################
      col += 1
      if row[col] == 'I'
        cat = 1
        elsif row[col] == 'II'
          cat = 2
      elsif row[col] == 'III'
        cat = 3
      end

      company.category = cat
      company.group = group

      company.cnpj = row[col += 1]
      company.address = row[col += 1]
      company.neighborhood = row[col += 1]
      company.cep = row[col += 1]
      company.city = row[col += 1]
      company.state = row[col += 1]
      company.email_address = row[col += 1]
      company.website = row[col += 1]

      # Contacts
      col = 11

      contact1 = Contact.new

      contact1.name = row[col += 1]
      contact1.position = row[col += 1]
      col += 1
      contact1.telephone = '85' + row[col].to_s unless row[col].nil?
      col += 1
      contact1.fax = '85' + row[col].to_s unless row[col].nil?
      col += 1
      contact1.celphone = '85' + row[col].to_s unless row[col].nil?
      contact1.email_address = row[col += 1]
      contact1.contact_type = 0

      contact2 = Contact.new
      contact2.name = row[col += 1]
      contact2.position = 'Secretária'
      col += 1
      contact2.telephone = '85' + row[col].to_s unless row[col].nil?
      col += 1
      contact2.celphone = '85' + row[col].to_s unless row[col].nil?
      contact2.email_address = row[col += 1]
      contact2.contact_type = 1

      col += 1
      contact3 = Contact.new
      contact3.name = row[col += 1]
      contact3.position = 'Setor financeiro'
      col += 1
      contact3.telephone = '85' + row[col].to_s unless row[col].nil?
      col += 1
      contact3.celphone = '85' + row[col].to_s unless row[col].nil?
      contact3.email_address = row[col += 1]
      contact3.contact_type = 2

      company.contacts.clear
      company.contacts.push contact1
      company.contacts.push contact2
      company.contacts.push contact3

      company
  end
end