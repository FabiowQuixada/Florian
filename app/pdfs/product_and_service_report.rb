class ProductAndServiceReport < FlorianReport

  def initialize(path, week)
    @path = path
    @week = week
  end

  def pdf
    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      render_header pdf, @week
      render_service_data pdf
      render_product_data pdf
      footer pdf
    end
  end

  def render_header(pdf, week)
    title, subtitle = title_and_subtitle(week)
    header pdf, title, subtitle
  end

  def title_and_subtitle(week)
    if week.number != 7
      title = I18n.t('report.title.weekly_prod_and_service')
      subtitle = (week.start_date.to_s + ' - ' + week.end_date.to_s)
    else
      title = I18n.t('report.title.monthly_prod_and_service')
      subtitle = I18n.localize(week.product_and_service_datum.competence, format: :competence).capitalize
    end

    [title, subtitle]
  end

  def render_service_data(pdf)

    table = build_service_table

    print_session_title pdf, I18n.t('helpers.prod_and_serv_datum.attendances')
    print_table pdf, table
  end

  def render_product_data(pdf)

    table = build_product_table

    print_session_title pdf, I18n.t('helpers.prod_and_serv_datum.product_output')
    print_table pdf, table
  end

  # rubocop:disable all
  def build_product_table
    table = []
    total_products = 0
    table << [I18n.t('activerecord.models.product_datum.other'), I18n.t('helpers.total')]

    ProductData.products.each do |product|
      product_qty = @week.product_data.instance_eval(product)
      total_products += product_qty
      table << [I18n.t('activerecord.attributes.product_datum.' + product), product_qty.to_s]
    end

    table << [I18n.t('helpers.total'), total_products]
  end

  def build_service_table
    table = []
    total_attendances = total_returns = 0

    table << [I18n.t('activerecord.models.service_datum.other'), I18n.t('activerecord.attributes.product_and_service_datum.attendances'), I18n.t('activerecord.attributes.product_and_service_datum.returns'), I18n.t('helpers.total')]
    ServiceData.services.each do |service|
      attd_qty = @week.attendances.instance_eval(service)
      rtn_qty = @week.returns.instance_eval(service)
      total_attendances += attd_qty
      total_returns += rtn_qty

      table << [I18n.t('activerecord.attributes.service_datum.' + service), attd_qty.to_s, rtn_qty.to_s, (attd_qty + rtn_qty).to_s]
    end

    table << [I18n.t('helpers.total'), total_attendances, total_returns, total_attendances + total_returns]
  end
  # rubocop:enable all

end
