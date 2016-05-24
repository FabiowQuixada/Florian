class FlorianReport < Prawn::Document
  attr_accessor :path

  PDF_OPTIONS = {
    :page_size   => "A4",
    :margin      => [40, 75]
  }


  def header(pdf, title, subtitle = '')

      # Title and subtitle box
      two_dimensional_array = pdf.make_table [[title],[subtitle]] do
          style(row(0), :size => 18, :padding_top =>  8)
          style(row(1), :size => 14, :padding_top => -5)
          cells.borders = []
      end

      # Logo and full title box
      pdf.table [[{:image => "#{Rails.root}/app/assets/images/logo_text.jpg", :scale => 0.4, :position => :center}, two_dimensional_array]], :position => :left do
        cells.column(0).row(0).style(:width => 60)
        cells.borders = []
      end
      pdf.move_down 30
  end

  def footer(pdf)
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 40], :width  => pdf.bounds.width do
        pdf.font "Helvetica"
        pdf.text I18n.t('report.footer.address'), :size => 10, :align => :center
        pdf.text I18n.t('report.footer.phone'), :size => 10, :align => :center
        pdf.text I18n.t('report.footer.email'), :size => 10, :align => :center
      end
  end

  def print_table(pdf, table)
    pdf.table table, :position => :center, :row_colors => ["DCE6F1", "FFFFFF"], :cell_style => {:align => :center, size: 8, :border_color => "4F81BD", border_width: 0.5 } do
        style(row(0), :size => 9, :font_style => :bold, :background_color => "4F81BD", :text_color => "FFFFFF")
        style(row(-1), :size => 9, :font_style => :bold, :background_color => "FFFFFF", border_width: 1)
        style(column(0), :align => :left)
      end
  end

  def print_session_title(pdf, title)
    pdf.move_down 30
      pdf.text title, :size => 15, :style => :bold, :align => :center
      pdf.move_down 10
  end

  def save
    pdf.render_file(path)
  end
end