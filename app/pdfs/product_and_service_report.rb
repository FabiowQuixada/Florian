class ProductAndServiceReport < Prawn::Document
  attr_accessor :path

  PDF_OPTIONS = {
    :page_size   => "A4",
    :margin      => [40, 75]
  }

  def initialize(path = nil, email)
      @path = path
      @email = email
  end

  def pdf
    Prawn::Document.new(PDF_OPTIONS) do |pdf|

      header pdf, I18n.t('report.title.prod_and_service'), @email.competence.capitalize

      pdf.text I18n.t('helpers.prod_and_serv_email.attendances'), :size => 15, :style => :bold, :align => :center
      pdf.move_down 10


      table = []
      total_a = 0
      total_b = 0

      table << [I18n.t('helpers.prod_and_serv_email.service'), I18n.t('helpers.prod_and_serv_email.checkup'), I18n.t('helpers.prod_and_serv_email.return'), I18n.t('helpers.prod_and_serv_email.total')]
      @email.class.services.each do |service|
        a = @email.instance_eval(service)
        b = @email.instance_eval(service + '_return')
        total_a += a
        total_b += b

        table << [I18n.t('activerecord.attributes.product_and_service_email.' + service), a.to_s, b.to_s, (a+b).to_s]
      end

      table << [I18n.t('helpers.prod_and_serv_email.total'), total_a, total_b, total_a + total_b]

      pdf.table table, :position => :center, :width => 300, :row_colors => ["DCE6F1", "FFFFFF"], :cell_style => {:align => :center, size: 8, :border_color => "4F81BD", border_width: 0.5 } do
        style(row(0), :size => 9, :font_style => :bold, :background_color => "4F81BD", :text_color => "FFFFFF")
        style(row(-1), :size => 9, :font_style => :bold, :background_color => "FFFFFF", border_width: 1)
        style(column(0), :align => :left)
      end


      ##################


      pdf.move_down 30
      pdf.text I18n.t('helpers.prod_and_serv_email.product_output'), :size => 15, :style => :bold, :align => :center
      pdf.move_down 10

      table = []
      total_products = 0
      table << [I18n.t('helpers.prod_and_serv_email.product'), I18n.t('helpers.prod_and_serv_email.total')]
      @email.class.products.each do |product|
        a = @email.instance_eval(product)
        total_products += a
        table << [I18n.t('activerecord.attributes.product_and_service_email.' + product), a.to_s]
      end

      table << [I18n.t('helpers.prod_and_serv_email.total'), total_products]
      pdf.table table, :position => :center, :width => 150, :row_colors => ["DCE6F1", "FFFFFF"], :cell_style => {:align => :center, size: 8, :border_color => "4F81BD", border_width: 0.5 } do
        style(row(0), :size => 9, :font_style => :bold, :background_color => "4F81BD", :text_color => "FFFFFF")
        style(row(-1), :size => 9, :font_style => :bold, :background_color => "FFFFFF", border_width: 1)
        style(column(0), :align => :left)
      end

      footer pdf

    end
  end

  def save
    pdf.render_file(path)
  end

  def header(pdf, title, subtitle)

      two_dimensional_array = pdf.make_table [[title],[subtitle]] do
          style(row(0), :size => 20)
          style(row(1), :size => 15, :padding_top => -5)
          cells.borders = []
      end

      pdf.table [[{:image => "#{Rails.root}/app/assets/images/logo_text.jpg", :scale => 0.4, :position => :center}, two_dimensional_array]], :position => :center do
        cells.column(0).row(0).style(:width => 60)
        cells.borders = []
      end
      pdf.move_down 50
  end

  def footer(pdf)
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 40], :width  => pdf.bounds.width do
        pdf.font "Helvetica"
        pdf.text I18n.t('report.footer.address'), :size => 10, :align => :center
        pdf.text I18n.t('report.footer.phone'), :size => 10, :align => :center
        pdf.text I18n.t('report.footer.email'), :size => 10, :align => :center
      end
  end
end