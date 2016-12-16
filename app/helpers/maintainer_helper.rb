module MaintainerHelper
  def search_entity_types
    hash = {}
    Maintainer.entity_types.each { |key| hash[I18n.t("enums.maintainer.entity_type.#{key[0]}")] = key[1] }
    hash
  end

  def search_categories
    hash = {}
    Maintainer.categories.each { |key| hash[I18n.t("enums.maintainer.category.#{key[0]}")] = key[1] }
    hash
  end

  def search_groups
    hash = {}
    Maintainer.groups.each { |key| hash[I18n.t("enums.maintainer.group.#{key[0]}")] = key[1] }
    hash
  end
end
