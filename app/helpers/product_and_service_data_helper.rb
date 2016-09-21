module ProductAndServiceDataHelper

  def fields_readonly?(week)
    week.totals? ||
      (week.product_and_service_datum && (week.product_and_service_datum.finalized? || (week.product_and_service_datum.on_analysis? && !week.final?)))
  end

  def week_range_readonly?(week)
    week.product_and_service_datum && (week.product_and_service_datum.finalized? || week.product_and_service_datum.on_analysis?)
  end

  def save_and_send_btn(week)
    link_to t('helpers.action.email.save_and_send'), 'javascript:void(0)', id: "update_and_send_btn_#{week.index}", class: 'btn btn-primary'
  end

  def send_to_analysis_btn
    link_to t('helpers.action.send_to_analysis'), 'javascript:void(0)', id: 'update_and_send_btn_5', class: 'btn btn-primary send_btn'
  end

  def copy_totals_to_final_btn
    link_to t('helpers.action.product_and_service.update_final_data'), 'javascript:void(0)', id: 'update_final_data_btn', class: 'btn btn-primary'
  end

  def send_mainteiners_btn
    link_to t('helpers.action.email.send'), 'javascript:void(0)', id: 'update_and_send_btn_6', class: 'btn btn-primary send_btn'
  end
end
