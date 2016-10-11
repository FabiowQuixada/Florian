module CompanyEnumHelper

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def i18n_entity_types
      hash = {}
      entity_types.keys.each { |key| hash[I18n.t("enums.company.entity_type.#{key}")] = key }
      hash
    end

    def i18n_categories
      hash = {}
      categories.keys.each { |key| hash[I18n.t("enums.company.category.#{key}")] = key }
      hash
    end

    def i18n_groups
      hash = {}
      groups.keys.each { |key| hash[I18n.t("enums.company.group.#{key}")] = key }
      hash
    end

    def i18n_contracts
      hash = {}
      contracts.keys.each { |key| hash[I18n.t("enums.company.contract_type.#{key}")] = key }
      hash
    end

    def i18n_payment_frequencies
      hash = {}
      payment_frequencies.keys.each { |key| hash[I18n.t("enums.company.payment_frequency.#{key}")] = key }
      hash
    end
  end

  def payment_frequency_desc
    I18n.t("enums.company.payment_frequency.#{payment_frequency}")
  end

  def group_desc
    I18n.t("enums.company.group.#{group}")
  end

  def category_desc
    I18n.t("enums.company.category.#{category}")
  end

end
