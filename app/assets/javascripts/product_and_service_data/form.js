$(() => { if(on_page('product_and_service_data', 'form')) product_and_service_data_form() });

const product_and_service_data_form = () => {
  set_number_of_tabs('prod_serv_data', 7);

  $('#main_form').submit(() => {
    if(on_action('edit')) {
      $("#aux_competence").prop("disabled", true);
      format_competence('aux_competence', 'product_and_service_datum_competence');
    }
  });

  const update_product_totals_from_tab = i => {
    let sum = 0;

    $(`.product_week_${i}`).each((i, field) => {
      if(!isNaN($(field).val()))
        sum = +sum + +$(field).val();
    });

    $(`#total_product_week_${i}`).val(sum);
  }

  const update_service_totals_from_tab = i => {
    let total_checkups = 0;
    let total_returns = 0;

    $(`.service-${i}-row`).each((i, field) => {
      let checkups = $(field).find('.service_checkup').val();
      let returns = $(field).find('.service_return').val();
      let total = $(field).find('.service_total');

      if(isNaN(checkups)) {
        checkups = 0;
      }

      if(isNaN(returns)) {
        returns = 0;
      }

      total_checkups += +checkups;
      total_returns += +returns;

      total.val(+checkups + +returns);
    });

    $(`#total_service_checkup_week_${i}`).val(total_checkups);
    $(`#total_service_return_week_${i}`).val(total_returns);
    $(`#total_service_week_${i}`).val(+total_checkups + +total_returns);
  }

  const update_service_totals_for_each_tab = () => {
    for (let i = 0; i <= Constants.week_final_number; i++) {
      update_service_totals_from_tab(i);
    }

    update_totals_tab();
  }

  const update_product_totals_for_each_tab = () => {
    for (let i = 0; i <= Constants.week_final_number; i++) {
      update_product_totals_from_tab(i);      
    }

    update_totals_tab();
  }

  const update_totals_tab = () => {
    const index = Constants.week_totals_number - 1;

    // Services;
    for (let col = 0; col < 2; col++) {
      for (let row = 0; row < Constants.number_of_services; row++) {

        let sum = 0;
        const field = `.service_row_${row}_col_${col}`;

        $(field).each((index, f) => {
          if(!$(f).hasClass("extra_tab")) {
            sum += +$(f).val();
          }
        });

        $(`.service_row_${row}_col_${col}.week_${index}`).val(sum);
      }
    };

    // Products;
    for (let row = 0; row < Constants.number_of_products; row++) {
      let sum = 0;
      const field = `.product_row_${row}`;

      $(field).each((index, f) => {
        if(!$(f).hasClass("extra_tab")) {
          sum += +$(f).val();
        }
      });

      $(`.product_row_${row}.week_${index}`).val(sum);

    };

    update_product_totals_from_tab(index);
    update_service_totals_from_tab(index);
  }

  const copy_from_totals_to_final_tab = () => {
    // Services;
    for (let col = 0; col < 2; col++) {
      for (let row = 0; row < Constants.number_of_services; row++) {
        const temp = $(`.service_row_${row}_col_${col}.week_5`).val();
        $(`.service_row_${row}_col_${col}.week_6`).val(temp);
      }
    };

    // Products;
    for (let row = 0; row < Constants.number_of_products; row++) {
      const temp = $(`.product_row_${row}.week_5`).val();
      $(`.product_row_${row}.week_6`).val(temp);
    };

    // Totals;
    update_product_totals_from_tab(6);
    update_service_totals_from_tab(6);
  }

  const set_request_url = source_week_number => {
    if(source_week_number === Constants.week_final_number - 1) {
      // The final (monthly) data will be sent to the the institute's maintainers.
      $('#hidden_week_form').attr('action', Constants.paths.send_maintainers_product_and_service_weeks);
    } else if(source_week_number === Constants.week_totals_number - 1) {
      $('#hidden_week_form').attr('action', Constants.paths.send_to_analysis_product_and_service_weeks);
    } else {
      // The partial (weekly) data will be sent to the collaborators;
      update_hidden_week_field('start_date', source_week_number);
      update_hidden_week_field('end_date', source_week_number);
    }
  }

  const update_hidden_serv_field = (attr, type, source_week_number) => {
    const target = $(`#product_and_service_week_service_data_attributes_${type}_${attr}`);
    const source = $(`#product_and_service_datum_product_and_service_weeks_attributes_${source_week_number}_service_data_attributes_${type}_${attr}`);

    target.val(source.val());
  }

  const update_hidden_prod_field = (attr, source_week_number) => {
    const target = $(`#product_and_service_week_product_data_attributes_${attr}`);
    const source = $(`#product_and_service_datum_product_and_service_weeks_attributes_${source_week_number}_product_data_attributes_${attr}`);

    target.val(source.val());
  }

  const update_hidden_week_field = (attr, source_week_number) => {
    const target = $(`#product_and_service_week_${attr}`);
    const source = $(`#product_and_service_datum_product_and_service_weeks_attributes_${source_week_number}_${attr}`);

    target.val(source.val());
  }

  const copy_to_hidden_form_and_send = source_week_number => {
    const product_list = Constants.products_array;
    const service_list = Constants.services_array;

    for(let i = 0; i < product_list.length; ++i) {
      update_hidden_prod_field(product_list[i], source_week_number);
    }

    for(let i = 0; i < service_list.length; ++i) {
      update_hidden_serv_field(service_list[i], 0, source_week_number);
      update_hidden_serv_field(service_list[i], 1, source_week_number);
    }

    update_hidden_week_field('id', source_week_number);
    update_hidden_serv_field('id', 0, source_week_number);
    update_hidden_serv_field('id', 1, source_week_number);
    update_hidden_prod_field('id', source_week_number);

    set_request_url(source_week_number);
    display_info(I18n.t("alert.email.sending"));
    $("#hidden_week_form").submit();
  }

  $("#aux_competence").prop("disabled", false);
  $('.service_input, .product_input').mask('999');
  $('#competence').val(current_competence());

  update_service_totals_for_each_tab();
  update_product_totals_for_each_tab();

  // Listeners;
  $('.service_input').on('blur', update_service_totals_for_each_tab);
  $('.product_input').on('blur', update_product_totals_for_each_tab);
  $('#update_final_data_btn').on('click', copy_from_totals_to_final_tab);
  $('#aux_competence').on('change', () => {
    format_competence('aux_competence', 'product_and_service_datum_competence');
  });

  for (let i = 0; i < Constants.number_of_weeks + 2; i++) {
    $(`#update_and_send_btn_${i}`).on('click', copy_to_hidden_form_and_send.bind(self, i));
  }

  copy_from_totals_to_final_tab();
}