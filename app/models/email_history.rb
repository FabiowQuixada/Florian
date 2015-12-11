class EmailHistory < ActiveRecord::Base

  enum type_values: { auto: 0, resend: 1, test: 2 }

  def self.types(hash = {})
    type_values.keys.each { |key| hash[key] = I18n.t("activerecord.attributes.email.type_values.#{key}") }
    hash
  end

  def type

  end

  def test?
    send_type == 2
  end


  belongs_to :user
  belongs_to :receipt_email

  usar_como_dinheiro :value

  def gender
    'm'
  end

  def number
    's'
  end

  def send_type_desc
    if send_type == 0
      return "Automático"
    elsif send_type == 1
      return "Reenvio"
    else
      return "Teste"
    end
  end
end
