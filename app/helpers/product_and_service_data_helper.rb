module ProductAndServiceDataHelper

	def fields_readonly?(week)
		totals_week_number = 6
		final_week_number = 7

		week.number == totals_week_number or 
		(week.product_and_service_datum and (week.product_and_service_datum.finalized? or (week.product_and_service_datum.on_analysis? and week.number != final_week_number)))
	end

	def week_range_readonly?(week)
		totals_week_number = 6
		final_week_number = 7

		week.product_and_service_datum and (week.product_and_service_datum.finalized? or week.product_and_service_datum.on_analysis?)
	end
end
