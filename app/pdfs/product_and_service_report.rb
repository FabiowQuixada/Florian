class ProductAndServiceReport < IaqReport

  def initialize(path = nil, email)
      @path = path
      @email = email
  end

  def pdf
    Prawn::Document.new(PDF_OPTIONS) do |pdf|

      header pdf, I18n.t('report.title.prod_and_service'), @email.competence.capitalize

      print_session_title pdf, I18n.t('helpers.prod_and_serv_datum.attendances')

      table = []
      total_a = 0
      total_b = 0

      table << [I18n.t('helpers.prod_and_serv_datum.service'), I18n.t('helpers.prod_and_serv_datum.checkup'), I18n.t('helpers.prod_and_serv_email.return'), I18n.t('helpers.prod_and_serv_email.total')]
      @email.class.services.each do |service|
        a = @email.instance_eval(service)
        b = @email.instance_eval(service + '_return')
        total_a += a
        total_b += b

        table << [I18n.t('activerecord.attributes.product_and_service_datum.' + service), a.to_s, b.to_s, (a+b).to_s]
      end

      table << [I18n.t('helpers.prod_and_serv_datum.total'), total_a, total_b, total_a + total_b]

      print_table pdf, table


      ##################

      print_session_title pdf, I18n.t('helpers.prod_and_serv_datum.product_output')


      table = []
      total_products = 0
      table << [I18n.t('helpers.prod_and_serv_email.product'), I18n.t('helpers.prod_and_serv_datum.total')]
      @email.class.products.each do |product|
        a = @email.instance_eval(product)
        total_products += a
        table << [I18n.t('activerecord.attributes.product_and_service_datum.' + product), a.to_s]
      end

      table << [I18n.t('helpers.prod_and_serv_datum.total'), total_products]

      print_table pdf, table

      footer pdf

    end
  end

end