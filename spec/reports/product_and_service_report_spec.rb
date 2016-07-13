require 'rails_helper'

describe ProductAndServiceReport do
  describe 'weekly report' do
    let(:week) { create :product_and_service_week }
    let(:rendered_pdf) { described_class.new('/tmp/prod_serv.pdf', week).pdf.render }
    let(:text_analysis) { PDF::Inspector::Text.analyze(rendered_pdf) }
    let(:page_analysis) { PDF::Inspector::Page.analyze(rendered_pdf) }

    it { expect(text_analysis.strings[0]).to eq(I18n.t('report.title.weekly_prod_and_service')) }
    it { expect(text_analysis.strings[1]).to eq(week.start_date.to_s + ' - ' + week.end_date.to_s) }

    it { validates_services }
    it { validates_products }

    it { expect(text_analysis.strings[-3]).to eq('Rua Visconde de Sabóia, nº 75 – Salas 01 a 16 - Centro – Cep: 60.030-090 - Fortaleza – CE') }
    it { expect(text_analysis.strings[-2]).to eq('Fone: 55 85 3251-1093') }
    it { expect(text_analysis.strings[-1]).to eq('E-mail: apoioaoqueimado@yahoo.com.br') }

    it { expect(page_analysis.pages.size).to eq(1) }
  end

  describe 'monthly report' do
    let(:psd) { create :product_and_service_datum }
    let(:week) { psd.final_week }
    let(:rendered_pdf) { described_class.new('/tmp/prod_serv.pdf', week).pdf.render }
    let(:text_analysis) { PDF::Inspector::Text.analyze(rendered_pdf) }
    let(:page_analysis) { PDF::Inspector::Page.analyze(rendered_pdf) }

    it { validates_services }
    it { validates_products }

    it { expect(text_analysis.strings[0]).to eq(I18n.t('report.title.monthly_prod_and_service')) }
    it { expect(text_analysis.strings[1]).to eq(I18n.localize(week.product_and_service_datum.competence, format: :competence).capitalize) }

    it { expect(text_analysis.strings[-3]).to eq('Rua Visconde de Sabóia, nº 75 – Salas 01 a 16 - Centro – Cep: 60.030-090 - Fortaleza – CE') }
    it { expect(text_analysis.strings[-2]).to eq('Fone: 55 85 3251-1093') }
    it { expect(text_analysis.strings[-1]).to eq('E-mail: apoioaoqueimado@yahoo.com.br') }

    it { expect(page_analysis.pages.size).to eq(1) }
  end

  def validates_services

    total_attendances = total_returns = 0

    ServiceData.services.each do |service|
      attendances, returns = validates_service(service)
      total_attendances += attendances
      total_returns += returns
    end

    # Totals
    expect(service_array[-3]).to eq(total_attendances.to_s)
    expect(service_array[-2]).to eq(total_returns.to_s)
    expect(service_array[-1]).to eq((total_attendances + total_returns).to_s)
  end

  def validates_service(service)
    index = text_analysis.strings.index { |o| o == I18n.t('activerecord.attributes.service_datum.' + service) }

    expected_attendance = week.service_data[0].send(service).to_s
    expected_return = week.service_data[0].send(service).to_s
    actual_attendance = text_analysis.strings[index + 1]
    actual_return = text_analysis.strings[index + 2]
    expected_total = expected_attendance.to_i + expected_return.to_i
    actual_total = actual_attendance.to_i + actual_return.to_i

    expect(actual_attendance).to eq(expected_attendance), service
    expect(actual_return).to eq(expected_return), service
    expect(actual_total).to eq(expected_total), service

    [expected_attendance.to_i, expected_return.to_i]
  end

  def validates_products
    total = 0

    ProductData.products.each do |product|
      total += validate_product(product)
    end

    # Total
    expect(product_array.last).to eq(total.to_s)
  end

  def validate_product(product)
    index = product_array.index { |o| o == I18n.t('activerecord.attributes.product_datum.' + product) }
    expect(product_array[index + 1]).to eq(week.product_data.send(product).to_s), product
    week.product_data.send(product)
  end

  def product_array
    text_analysis.strings[36..55]
  end

  def service_array
    text_analysis.strings[3..34]
  end
end
