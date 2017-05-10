import I18n from "./../../i18n";
import { on_page, on_action } from "./../support/application";
import { current_competence, format_competence } from "./../support/dates";
import Constants from "./../../server_constants";
import { display_info } from "./../support/message_area";
import { set_number_of_tabs } from "./../support/tab_commons";
import * as service_module from "./service_module";
import * as product_module from "./product_module";

$(() => { if(on_page("product_and_service_data", "form")) new ProductAndServiceDataForm(); });

const ProductAndServiceDataForm = (function() {
  function ProductAndServiceDataForm() {
    this.update_totals_tab = () => {
      product_module.update_totals_tab();
      service_module.update_totals_tab();
    };

    this.copy_from_totals_to_final_tab = () => {
      service_module.copy_data_from_totals_to_final_tab();
      product_module.copy_data_from_totals_to_final_tab();
      product_module.update_totals_from_tab(6);
      service_module.update_totals_from_tab(6);
    };

    this.set_request_url = source_week_number => {
      if(this.is_totals_week(source_week_number)) {
        this.prepare_form_to_analysis();
        return;
      }

      if(this.is_final_week(source_week_number)) {
        this.prepare_form_to_maintainers();
        return;
      }

      this.prepare_form_to_collaborators(source_week_number);
    };

    this.is_final_week = number => number === Constants.week_final_number - 1;
    this.is_totals_week = number => number === Constants.week_totals_number - 1;

    this.prepare_form_to_maintainers = () => {
      $("#hidden_week_form").attr("action", Constants.paths.send_maintainers_product_and_service_weeks);
    };

    this.prepare_form_to_analysis = () => {
      $("#hidden_week_form").attr("action", Constants.paths.send_to_analysis_product_and_service_weeks);
    };

    this.prepare_form_to_collaborators = source_week_number => {
      this.set_hidden_week_field("start_date", source_week_number);
      this.set_hidden_week_field("end_date", source_week_number);
    };

    this.set_hidden_week_field = (attr, source_week_number) => {
      $(`#hiddenweek_week_${attr}`).val(
        $(`#w${source_week_number}_week_${attr}`).val()
      );
    };

    this.copy_to_hidden_form_and_send = source_week_number => {
      service_module.copy_data_to_hidden_form(source_week_number);
      product_module.copy_data_to_hidden_form(source_week_number);

      this.set_hidden_week_field("id", source_week_number);

      this.set_request_url(source_week_number);
      display_info(I18n.t("alert.email.sending"));
      $("#hidden_week_form").submit();
    };

    this.setup_listeners = () => {
      const origin = this;
      service_module.setup_listeners();
      product_module.setup_listeners();

      $("body").on("change", "#aux_competence",
        () => { format_competence("aux_competence", "product_and_service_datum_competence"); }
      );

      $("body").on("click", "#update_final_data_btn",
        () => { this.copy_from_totals_to_final_tab(); }
      );

      for (let i = 0; i < Constants.number_of_weeks-2; i++) {
        $("body").on("click", `#update_and_send_btn_${i}`,
          () => { origin.copy_to_hidden_form_and_send(i); }
        );
      }

      $("#main_form").submit(() => {
        if(on_action("edit")) {
          $("#aux_competence").prop("disabled", true);
          format_competence("aux_competence", "product_and_service_datum_competence");
        }
      });
    };

    this.initalize_fields = () => {
      $("#aux_competence").prop("disabled", false);
      $("#competence").val(current_competence());
    };

    set_number_of_tabs("prod_serv_data", 7);
    service_module.update_totals_for_each_tab();
    product_module.update_totals_for_each_tab();
    this.copy_from_totals_to_final_tab();
    this.initalize_fields();
    this.setup_listeners();
  }

  return ProductAndServiceDataForm;
}());

export default ProductAndServiceDataForm;
