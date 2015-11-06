class ReceiptReport < Prawn::Document
  attr_accessor :path

  PDF_OPTIONS = {
    :page_size   => "A4",
    :margin      => [40, 75]
  }
  
  def initialize(path = nil, email, date)
      @path = path
      @email = email
      @date = date
    end

  def pdf
    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      
      # Header
      pdf.image "#{Rails.root}/app/assets/images/logo_text.jpg", :scale => 0.7, position: :center
      pdf.text "Recibo", :size => 25, :style => :bold, :align => :center

      # Value
      pdf.move_down 30
      pdf.text ActionController::Base.helpers.number_to_currency(@email.value), :size => 18, :style => :bold, :align => :right

      # Main text
      pdf.move_down 30
      pdf.text @email.processed_pdf_text, :inline_format => true, :align => :justify, :indent_paragraphs => 30

      # Bank account
      pdf.move_down 30
      pdf.indent(20) do
        pdf.text "DADOS PARA DEPÓSITO", :inline_format => true, :style => :bold
        pdf.text "Banco: Itaú (341)", :inline_format => true
        pdf.text "Agência: 8373", :inline_format => true
        pdf.text "Conta Corrente: 14373-7", :inline_format => true
      end
      
      # Place / time
      pdf.move_down 30
      pdf.text "Fortaleza, " + I18n.localize(Date.today, format: :long), :inline_format => true, :align => :center

      # Signature
      pdf.move_down 30
      pdf.image "#{Rails.root}/app/assets/images/president_signature.png", :scale => 0.15, position: :center
      pdf.text "Dr. Edmar Maciel Lima Júnior", :inline_format => true, :style => :bold, :align => :center
      pdf.text "Presidente do Instituto de Apoio ao Queimado – I.A.Q.", :inline_format => true, :style => :bold, :align => :center

      # Footer
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 40], :width  => pdf.bounds.width do
        pdf.font "Helvetica"
        pdf.text "Rua Visconde de Sabóia, nº 75 – Salas 01 a 16 - Centro – Cep: 60.030-090 - Fortaleza – CE", :size => 10, :align => :center
        pdf.text "Fone: 55 85 3251-1093", :size => 10, :align => :center
        pdf.text "E-mail: apoioaoqueimado@yahoo.com.br", :size => 10, :align => :center
      end
    end
  end
  
  def save
    pdf.render_file(path)
  end
end