require 'rails_helper'

describe ProductAndServiceReport do
  context 'Weekly report' do
    before(:each) do
      create :product_and_service_datum
      @week = ProductAndServiceWeek.first

      rendered_pdf = described_class.new('/tmp/prod_serv.pdf', @week).pdf.render
      @text_analysis = PDF::Inspector::Text.analyze(rendered_pdf)
      @page_analysis = PDF::Inspector::Page.analyze(rendered_pdf)
    end

    it { expect(@text_analysis.strings[0]).to eq(I18n.t('report.title.weekly_prod_and_service')) }
    it { expect(@text_analysis.strings[1]).to eq(@week.start_date.to_s + ' - ' + @week.end_date.to_s) }

    it { validates_services }
    it { validates_products }

    it { expect(@text_analysis.strings[-3]).to eq('Rua Visconde de Sabóia, nº 75 – Salas 01 a 16 - Centro – Cep: 60.030-090 - Fortaleza – CE') }
    it { expect(@text_analysis.strings[-2]).to eq('Fone: 55 85 3251-1093') }
    it { expect(@text_analysis.strings[-1]).to eq('E-mail: apoioaoqueimado@yahoo.com.br') }

    it { expect(@page_analysis.pages.size).to eq(1) }
  end

  context 'Monthly report' do
    before(:each) do
      psd = create :product_and_service_datum
      @week = psd.final_week

      rendered_pdf = described_class.new('/tmp/prod_serv.pdf', @week).pdf.render
      @text_analysis = PDF::Inspector::Text.analyze(rendered_pdf)
      @page_analysis = PDF::Inspector::Page.analyze(rendered_pdf)
    end

    it { validates_services }
    it { validates_products }

    it { expect(@text_analysis.strings[0]).to eq(I18n.t('report.title.monthly_prod_and_service')) }
    it { expect(@text_analysis.strings[1]).to eq(I18n.localize(@week.product_and_service_datum.competence, format: :competence).capitalize) }

    it { expect(@text_analysis.strings[-3]).to eq('Rua Visconde de Sabóia, nº 75 – Salas 01 a 16 - Centro – Cep: 60.030-090 - Fortaleza – CE') }
    it { expect(@text_analysis.strings[-2]).to eq('Fone: 55 85 3251-1093') }
    it { expect(@text_analysis.strings[-1]).to eq('E-mail: apoioaoqueimado@yahoo.com.br') }

    it { expect(@page_analysis.pages.size).to eq(1) }
  end

  def validates_services

    total_attendances = 0
    total_returns = 0
    index = 0

    ServiceData.services.each do |service|
      index = @text_analysis.strings.index { |o| o == I18n.t('activerecord.attributes.service_datum.' + service) }

      expected_attendance = @week.service_data[0].send(service).to_s
      expected_return = @week.service_data[0].send(service).to_s
      actual_attendance = @text_analysis.strings[index + 1]
      actual_return = @text_analysis.strings[index + 2]
      expected_total = expected_attendance.to_i + expected_return.to_i
      actual_total = actual_attendance.to_i + actual_return.to_i
      total_attendances += expected_attendance.to_i
      total_returns += expected_return.to_i

      expect(actual_attendance).to eq(expected_attendance), (service + ' attendance: expected ' + expected_attendance + ', got ' + actual_attendance)
      expect(actual_return).to eq(expected_return), (service + ' return: expected ' + expected_return + ', got ' + actual_return)
      expect(actual_total).to eq(expected_total), (service + ' return: expected ' + expected_total.to_s + ', got ' + actual_total.to_s)
    end

    # Totals
    expect(@text_analysis.strings[index + 5]).to eq(total_attendances.to_s)
    expect(@text_analysis.strings[index + 6]).to eq(total_returns.to_s)
    expect(@text_analysis.strings[index + 7]).to eq((total_attendances + total_returns).to_s)
  end

  def validates_products
    total = 0
    index = 0

    product_array = @text_analysis.strings[36, 53]

    ProductData.products.each do |product|
      index = product_array.index { |o| o == I18n.t('activerecord.attributes.product_datum.' + product) }

      expect(product_array[index + 1]).to eq(@week.product_data.send(product).to_s), (product + ': expected ' + @week.product_data.send(product).to_s + ', got ' + product_array[index + 1])
      total += @week.product_data.send(product)
    end

    # Total
    expect(product_array[index + 3]).to eq(total.to_s)
  end
end
