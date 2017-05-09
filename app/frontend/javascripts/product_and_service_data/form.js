import I18n from './../i18n';
import { on_page, on_action } from './../application';
import { current_competence, format_competence } from './../dates';
import Constants from './../server_constants';
import { display_info } from './../message_area';
import { set_number_of_tabs } from './../tab_commons';

$(() => { if(on_page('product_and_service_data', 'form')) new ProductAndServiceDataForm(); });

const ProductAndServiceDataForm = (function() {
  function ProductAndServiceDataForm() {

    this.update_product_totals_from_tab = i => {
      let sum = 0;

      $(`.product_week_${i}`).each((i, field) => {
        if(!isNaN($(field).val()))
          sum = +sum + +$(field).val();
      });

      $(`#total_product_week_${i}`).val(sum);
    };

    this.update_service_totals_from_tab = i => {
      let total_checkups = 0;
      let total_returns = 0;

      $(`.service-${i}-row`).each((i, field) => {
        const { checkups, returns } = this.update_service_totals_column_from($(field));
        total_checkups += +checkups;
        total_returns += +returns;
      });

      $(`#total_service_checkup_week_${i}`).val(total_checkups);
      $(`#total_service_return_week_${i}`).val(total_returns);
      $(`#total_service_week_${i}`).val(+total_checkups + +total_returns);
    };

    this.update_service_totals_column_from = row => {
      let checkups = row.find('.service_checkup').val();
      let returns = row.find('.service_return').val();
      let total = row.find('.service_total');

      if(isNaN(checkups)) {
        checkups = 0;
      }

      if(isNaN(returns)) {
        returns = 0;
      }

      total.val(+checkups + +returns);

      return { checkups, returns };
    };

    this.update_service_totals_for_each_tab = () => {
      for (let i = 0; i <= Constants.week_final_number; i++) {
        this.update_service_totals_from_tab(i);
      }

      this.update_totals_tab();
    };

    this.update_product_totals_for_each_tab = () => {
      for (let i = 0; i <= Constants.week_final_number; i++) {
        this.update_product_totals_from_tab(i);
      }

      this.update_totals_tab();
    };

    this.update_totals_tab = () => {
      const index = Constants.week_totals_number - 1;

      for (let col = 0; col < 2; col++) {
        for (let row = 0; row < Constants.number_of_services; row++) {
          this.update_services_in_totals_tab(row, col);
        }
      }

      for (let row = 0; row < Constants.number_of_products; row++) {
        this.update_products_in_totals_tab(row);
      }

      this.update_product_totals_from_tab(index);
      this.update_service_totals_from_tab(index);
    };

    this.update_services_in_totals_tab = (row, col) => {
      const index = Constants.week_totals_number - 1;
      const field = `.service_row_${row}_col_${col}`;
      let sum = 0;

      $(field).each((index, f) => {
        if(!$(f).hasClass("extra_tab")) {
          sum += +$(f).val();
        }
      });

      $(`.service_row_${row}_col_${col}.week_${index}`).val(sum);
    };

    this.update_products_in_totals_tab = row => {
      const index = Constants.week_totals_number - 1;
      const field = `.product_row_${row}`;
      let sum = 0;

      $(field).each((index, f) => {
        if(!$(f).hasClass("extra_tab")) {
          sum += +$(f).val();
        }
      });

      $(`.product_row_${row}.week_${index}`).val(sum);
    };

    this.copy_from_totals_to_final_tab = () => {
      this.copy_services_from_totals_to_final_tab();
      this.copy_products_from_totals_to_final_tab();
      this.update_product_totals_from_tab(6);
      this.update_service_totals_from_tab(6);
    };

    this.copy_services_from_totals_to_final_tab = () => {
      for (let col = 0; col < 2; col++) {
        for (let row = 0; row < Constants.number_of_services; row++) {
          const temp = $(`.service_row_${row}_col_${col}.week_5`).val();
          $(`.service_row_${row}_col_${col}.week_6`).val(temp);
        }
      }
    };

    this.copy_products_from_totals_to_final_tab = () => {
      for (let row = 0; row < Constants.number_of_products; row++) {
        const temp = $(`.product_row_${row}.week_5`).val();
        $(`.product_row_${row}.week_6`).val(temp);
      }
    };

    this.set_request_url = source_week_number => {
      if(source_week_number === Constants.week_final_number - 1) {
        // The final (monthly) data will be sent to the the institute's maintainers.
        $('#hidden_week_form').attr('action', Constants.paths.send_maintainers_product_and_service_weeks);
      } else if(source_week_number === Constants.week_totals_number - 1) {
        // The final (monthly) data will be sent analysis before being sent to maintainers;
        $('#hidden_week_form').attr('action', Constants.paths.send_to_analysis_product_and_service_weeks);
      } else {
        // The partial (weekly) data will be sent to the collaborators;
        this.update_hidden_week_field('start_date', source_week_number);
        this.update_hidden_week_field('end_date', source_week_number);
      }
    };

    this.update_hidden_serv_field = (attr, type, source_week_number) => {
      const target = $(`#product_and_service_week_service_data_attributes_${type}_${attr}`);
      const source = $(`#product_and_service_datum_product_and_service_weeks_attributes_${source_week_number}_service_data_attributes_${type}_${attr}`);

      target.val(source.val());
    };

    this.update_hidden_prod_field = (attr, source_week_number) => {
      const target = $(`#product_and_service_week_product_data_attributes_${attr}`);
      const source = $(`#product_and_service_datum_product_and_service_weeks_attributes_${source_week_number}_product_data_attributes_${attr}`);

      target.val(source.val());
    };

    this.update_hidden_week_field = (attr, source_week_number) => {
      const target = $(`#product_and_service_week_${attr}`);
      const source = $(`#product_and_service_datum_product_and_service_weeks_attributes_${source_week_number}_${attr}`);

      target.val(source.val());
    };

    this.copy_to_hidden_form_and_send = source_week_number => {
      const product_list = Constants.products_array;
      const service_list = Constants.services_array;

      for(let i = 0; i < product_list.length; ++i) {
        this.update_hidden_prod_field(product_list[i], source_week_number);
      }

      for(let i = 0; i < service_list.length; ++i) {
        this.update_hidden_serv_field(service_list[i], 0, source_week_number);
        this.update_hidden_serv_field(service_list[i], 1, source_week_number);
      }

      this.update_hidden_week_field('id', source_week_number);
      this.update_hidden_serv_field('id', 0, source_week_number);
      this.update_hidden_serv_field('id', 1, source_week_number);
      this.update_hidden_prod_field('id', source_week_number);

      this.set_request_url(source_week_number);
      display_info(I18n.t("alert.email.sending"));
      $("#hidden_week_form").submit();
    };

    this.setup_listeners = () => {
      $('.service_input').on('blur', this.update_service_totals_for_each_tab);
      $('.product_input').on('blur', this.update_product_totals_for_each_tab);
      $('#update_final_data_btn').on('click', this.copy_from_totals_to_final_tab);
      $('#aux_competence').on('change', () => {
        format_competence('aux_competence', 'product_and_service_datum_competence');
      });

      for (let i = 0; i <= Constants.number_of_weeks + 1; i++) {
        $(`#update_and_send_btn_${i}`).on('click', this.copy_to_hidden_form_and_send.bind(self, i));
      }

      $('#main_form').submit(() => {
        if(on_action('edit')) {
          $("#aux_competence").prop("disabled", true);
          format_competence('aux_competence', 'product_and_service_datum_competence');
        }
      });
    };

    this.initalize_fields = () => {
      $("#aux_competence").prop("disabled", false);
      // $('.service_input, .product_input').mask('999');
      $('#competence').val(current_competence());
    };

    set_number_of_tabs('prod_serv_data', 7);
    this.update_service_totals_for_each_tab();
    this.update_product_totals_for_each_tab();
    this.copy_from_totals_to_final_tab();
    this.initalize_fields();
    this.setup_listeners();
  }

  return ProductAndServiceDataForm;
}());

export default ProductAndServiceDataForm;
