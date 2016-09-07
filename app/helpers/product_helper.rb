module ProductHelper

  def product_classes(week, product_row)
    "form-control product_input numbers_only product_row_#{product_row} product_week_#{week.index} input-sm week_#{week.index}" + (week.common? ? '' : ' extra_tab temp_field')
  end

  def product_id(week)
    " (#{week.product_data.id})"
  end
end
