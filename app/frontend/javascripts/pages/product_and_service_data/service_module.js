import Constants from "./../../server_constants";
import { sum } from "./../../utils";

export const update_totals_from_tab = t => {
  update_each_row_total(t);
  uptade_checkup_footer(t);
  uptade_return_footer(t);
  uptade_absolute_total(t);
};

export const copy_data_from_totals_to_final_tab = () => {
  Constants.services_array.forEach( service => {
    $(`#w6_service_${service}_c0`).val($(`#w5_service_${service}_c0`).val());
    $(`#w6_service_${service}_c1`).val($(`#w5_service_${service}_c1`).val());
  });
};

export const set_hidden_week_field = (attr, type, source_week_number) => {
  $(`#hiddenweek_service_${attr}_c${type}`).val(
    $(`#w${source_week_number}_service_${attr}_c${type}`).val()
  );
};

export const update_totals_tab = () => {
  Constants.services_array.forEach( service => {
    $(`#w5_service_${service}_c0`).val(sum(`.service_${service}_c0:not(.extra_tab)`));
    $(`#w5_service_${service}_c1`).val(sum(`.service_${service}_c1:not(.extra_tab)`));
  });

  update_totals_from_tab(Constants.week_totals_number - 1);
};

export const copy_data_to_hidden_form = source_week_number => {
  Constants.services_array.forEach( service => {
    set_hidden_week_field(service, 0, source_week_number);
    set_hidden_week_field(service, 1, source_week_number);
  });

  set_hidden_week_field("id", 0, source_week_number);
  set_hidden_week_field("id", 1, source_week_number);
};

export const update_totals_for_each_tab = () => {
  for (let i = 0; i <= Constants.week_final_number; i++) {
    update_totals_from_tab(i);
  }

  update_totals_tab();
};

export const setup_listeners = () => {
  $("body").on("change", ".service_input",
    () => { update_totals_for_each_tab(); }
  );
};

// Private functions //////////////////////////////////////////////////////////////////////////////

const update_each_row_total = w => {
  Constants.services_array.forEach( service => {
    $(`#w${w}_service_${service}_total`).val(
      sum(`#prod_serv_data_tab_${w} .${service}-row input:not(.service_total_field_column)`)
    );
  });
};

const uptade_checkup_footer = w => {
  $(`#w${w}_service_checkup_total`).val(
    sum(`#prod_serv_data_tab_${w} input.service_checkup:not(.service_total_field_row)`)
  );
};

const uptade_return_footer = w => {
  $(`#w${w}_service_return_total`).val(
    sum(`#prod_serv_data_tab_${w} input.service_return:not(.service_total_field_row)`)
  );
};

const uptade_absolute_total = w => {
  $(`#w${w}_service_absolute_total`).val(
    sum(`#prod_serv_data_tab_${w} input.service_total_field_row`)
  );
};
