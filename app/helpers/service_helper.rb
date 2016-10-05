module ServiceHelper

  def service_field_tag(week, service, serv_type, row)
    if week.helper?
      text_field_tag "product_and_service_week[service_data_attributes][#{serv_type}][#{service}]", week.service_data[serv_type].instance_eval(service), class: service_field_classes(week, service, serv_type, row), disabled: week.totals?
    else
      text_field_tag "product_and_service_datum[product_and_service_weeks_attributes][#{week.index}][service_data_attributes][#{serv_type}][#{service}]", week.service_data[serv_type].instance_eval(service), class: service_field_classes(week, service, serv_type, row), readonly: fields_readonly?(week)
    end
  end

  def service_field_classes(week, service, serv_type, row)
    serv_class(serv_type, week) + " form-control #{service} week_#{week.index} numbers_only service_input input-sm service_row_#{row}_col_#{serv_type}" + (week.common? ? '' : ' extra_tab temp_field')
  end

  def serv_class(serv_type, week)
    if serv_type == 0
      "attendance attendance_week_#{week.index} service_checkup"
    elsif serv_type == 1
      "return return_week_#{week.index} service_return"
    end
  end

  def services_ids(week)
    " (#{week.service_data[0].id}, #{week.service_data[1].id})"
  end
end
