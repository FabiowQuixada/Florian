module ServiceHelper
  def service_field_tag(week, service, serv_type, row)
    text_field_tag "product_and_service_datum[product_and_service_weeks_attributes][#{week.index}][service_data_attributes][#{serv_type}][#{service}]",
                   week.service_data[serv_type].instance_eval(service),
                   id: "w#{week.index}_service_#{service}_c#{serv_type}",
                   maxlength: 3,
                   class: service_field_classes(week, service, serv_type, row),
                   readonly: fields_readonly?(week)
  end

  def service_field_classes(week, service, serv_type, _row)
    "form-control numbers_only service_input input-sm service_#{service}_c#{serv_type} " +
      (week.common? ? '' : ' extra_tab temp_field') +
      (serv_type == 0 ? ' service_checkup' : ' service_return')
  end

  def services_ids(week)
    " (#{week.service_data[0].id}, #{week.service_data[1].id})"
  end
end
