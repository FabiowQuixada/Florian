module ProductAndServiceDataHelper

  def fields_readonly?(week)
    totals_week_number = 6
    final_week_number = 7

    week.number == totals_week_number ||
      (week.product_and_service_datum && (week.product_and_service_datum.finalized? || (week.product_and_service_datum.on_analysis? && week.number != final_week_number)))
  end

  def week_range_readonly?(week)
    week.product_and_service_datum && (week.product_and_service_datum.finalized? || week.product_and_service_datum.on_analysis?)
  end
end
