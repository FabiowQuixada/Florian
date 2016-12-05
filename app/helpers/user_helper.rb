module UserHelper
  def available_locales
    hash = {}
    I18n.available_locales.each { |key| hash[I18n.t("locale.#{key}")] = key }
    hash
  end
end
