module LocaleHandler

  # TODO: Currency to words in English
  def self.full_money_desc(value)
    return ActionController::Base.helpers.number_to_currency(value) unless I18n.locale == :"pt-BR"

    "#{ActionController::Base.helpers.number_to_currency(value)} (#{value.real.por_extenso})"
  end
end
