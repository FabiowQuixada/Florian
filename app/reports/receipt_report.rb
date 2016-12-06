class ReceiptReport < FlorianReport

  def initialize(path, email, date)
    @path = path
    @email = email
    @date = date
  end

  def pdf
    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      header pdf, I18n.t('report.title.receipt'), I18n.localize(@date, format: :competence).capitalize
      render_value pdf
      render_main_text pdf
      render_bank_data pdf
      render_date_place pdf
      render_signature pdf
      footer pdf
    end
  end

  def render_value(pdf)
    pdf.move_down 30
    pdf.text ActionController::Base.helpers.number_to_currency(@email.value), size: 18, style: :bold, align: :right
  end

  def render_main_text(pdf)
    pdf.move_down 30
    pdf.text @email.processed_receipt_text(@date), inline_format: true, align: :justify, indent_paragraphs: 30
  end

  def render_bank_data(pdf)
    pdf.move_down 30
    pdf.indent(20) do
      pdf.text I18n.t('report.other.banking.deposit_data'), inline_format: true, style: :bold
      bank_line(pdf, 'bank', NGO_BANK)
      bank_line(pdf, 'agency', NGO_AGENCY)
      bank_line(pdf, 'account', NGO_ACCOUNT)
    end
  end

  def render_date_place(pdf)
    settings = SystemSetting.first
    pdf.move_down 30
    pdf.text "#{settings.city}, #{I18n.localize(Date.today, format: :long)}", inline_format: true, align: :center
  end

  def render_signature(pdf)
    EnvironmentContentHandler.render_president_signature pdf
  end

  def bank_line(pdf, tag, value)
    pdf.text "#{I18n.t('report.other.banking.' + tag.to_s)}: #{value}", inline_format: true
  end
end
