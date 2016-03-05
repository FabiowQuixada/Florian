class ExcelParser
 def self.parse

  inconsistent_companies = Array.new

         file = Roo::Excel.new(Rails.root.join('app', 'assets', 'empresas_2016.xls'))

         file.worksheets.each_with_index do |sheet, index|

          # Get companies
          for r in 4..(sheet.count-1)

              row = sheet.rows[r]

              company = parse_company row, (index+1)

              if !company.save
                  inconsistent_companies << company
              end
          end # Row loop end

         end # Sheet loop end


         inconsistent_companies.each do |company|
          puts company

          company.errors.full_messages.each do |error_message| 
           puts error_message
          end 

         end
    end

    private

    def self.parse_company(row, group)

      col = 0
      company = Company.new

      if row[col] == 'PF'
        company.entity_type = 2
      else
        company.entity_type = 1
      end

      col += 1
      company.registration_name = row[col]
      company.name = row[col += 1]

      cat = 0
      col += 1
      if row[col] == 'I'
        cat = 1
        elsif row[col] == 'II'
          cat = 2
      elsif row[col] == 'III'
        cat = 3
      end

      
      company.category = cat
      company.group = 1

      if company.person?
        company.cpf = row[col += 1]
      else
        company.cnpj = row[col += 1]
      end

      company.address = row[col += 1]
      company.neighborhood = row[col += 1]
      company.cep = row[col += 1]
      company.city = row[col += 1]
      company.state = row[col += 1]
      company.email_address = row[col += 1]
      company.website = row[col += 1]


      # Contacts
      col = 12

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

      # Donation
      donation = Donation.new
      temp = row[col += 1]

      if temp.is_a? Numeric
        donation.value = temp
      else
        donation.remark = temp
      end

      temp = row[col += 1]
      if temp == "Mensal"
        company.payment_frequency = 3
      elsif temp == "Diariamente"
        company.payment_frequency = 1
      elsif temp == "Bimestral"
        company.payment_frequency = 4
      elsif temp == "Semanal"
        company.payment_frequency = 2
      elsif temp == "Indeterminado"
        company.payment_frequency = 8
      elsif temp == "Anual"
        company.payment_frequency = 6
      elsif temp == "Semestral"
        company.payment_frequency = 5
      else
      end

      temp = row[col += 1]
      if temp == "Indeterminado"
        company.payment_period = 0
      elsif temp.is_a? Numeric
        company.payment_period = temp
      end


      company.first_parcel = row[col += 1]

      # Ignores 'Ultima parcela'
      col += 1

      temp = row[col += 1]
      if temp == "Contrato"
        company.contract = 1
      elsif temp == "Sem contrato"
        company.contract = 2
      end

      company
  end
end