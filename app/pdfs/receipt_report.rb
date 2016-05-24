class ReceiptReport < FlorianReport

  def initialize(path = nil, email, date)
      @path = path
      @email = email
      @date = date
    end

  def pdf
      Prawn::Document.new(PDF_OPTIONS) do |pdf|

        # Header
        header pdf, I18n.t('report.title.receipt')

        # Value
        pdf.move_down 30
        pdf.text ActionController::Base.helpers.number_to_currency(@email.value), :size => 18, :style => :bold, :align => :right

        # Main text
        pdf.move_down 30
        pdf.text @email.processed_receipt_text(@date), :inline_format => true, :align => :justify, :indent_paragraphs => 30

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
        pdf.move_up 15
        pdf.text I18n.t('report.president_name'), :inline_format => true, :style => :bold, :align => :center
        pdf.text I18n.t('report.president_description'), :inline_format => true, :style => :bold, :align => :center

        footer pdf

      end
  end
end