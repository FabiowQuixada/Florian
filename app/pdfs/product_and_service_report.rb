class ProductAndServiceReport < IaqReport

  def initialize(path = nil, week)
      @path = path
      @week = week
  end

  def pdf
    Prawn::Document.new(PDF_OPTIONS) do |pdf|

      header pdf, I18n.t('report.title.weekly_prod_and_service'), (@week.start_date.to_s + ' - ' + @week.end_date.to_s)

      print_session_title pdf, I18n.t('helpers.prod_and_serv_datum.attendances')

      table = []
      total_a = 0
      total_b = 0

      table << [I18n.t('activerecord.models.service_datum.other'), I18n.t('activerecord.attributes.product_and_service_datum.attendances'), I18n.t('activerecord.attributes.product_and_service_datum.returns'), I18n.t('helpers.total')]
      ServiceData.services.each do |service|
        a = @week.service_data[0].instance_eval(service)
        b = @week.service_data[1].instance_eval(service)
        total_a += a
        total_b += b

        table << [I18n.t('activerecord.attributes.service_datum.' + service), a.to_s, b.to_s, (a+b).to_s]
      end

      table << [I18n.t('helpers.total'), total_a, total_b, total_a + total_b]

      print_table pdf, table


      ##################

      print_session_title pdf, I18n.t('helpers.prod_and_serv_datum.product_output')


      table = []
      total_products = 0
      table << [I18n.t('activerecord.models.product_datum.other'), I18n.t('helpers.total')]
      ProductData.products.each do |product|
        a = @week.product_data.instance_eval(product)
        total_products += a
        table << [I18n.t('activerecord.attributes.product_datum.' + product), a.to_s]
      end

      table << [I18n.t('helpers.total'), total_products]

      print_table pdf, table

      footer pdf

    end
  end

end