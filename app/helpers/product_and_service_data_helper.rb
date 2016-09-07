module ProductAndServiceDataHelper

  def fields_readonly?(week)
    week.totals? ||
      (week.product_and_service_datum && (week.product_and_service_datum.finalized? || (week.product_and_service_datum.on_analysis? && !week.final?)))
  end

  def week_range_readonly?(week)
    week.product_and_service_datum && (week.product_and_service_datum.finalized? || week.product_and_service_datum.on_analysis?)
  end
end
