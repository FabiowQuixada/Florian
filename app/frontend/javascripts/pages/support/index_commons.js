import I18n from "./../../i18n";
import { on_action } from "./../support/application";
import { display_confirm_modal } from "./../support/modals";
import { display_notice, display_error } from "./../support/message_area";
import ServerFunctions from "./../../server_functions";

$(() => { if(on_action("index")) new IndexCommons(); });

const IndexCommons = (function() {
  function IndexCommons() {
    this.setup_filter_panel = () => {
      $("#index_filters.panel-collapse").collapse("hide");

      $("#index_filters input:not([type='submit']), #index_filters select").each((index, field) => {
        if ($(field).val()) {
          $("#index_filters.panel-collapse").collapse("show");
          return;
        }
      });
    };

    this.setup_listeners = () => {
      const that = this;

      $(".clean_filters_btn").on("click", () => {
        const model = $("#rails_model").val();
        window.location = ServerFunctions.paths.index(model);
      });

      $("#index_table").on("click", ".status_btn", e => {
        const id = $(e.currentTarget).closest(".model_row").find(".model_id").html();
        that.update_status(id);
      });

      $(".destroy_btn").on("click", e => {
        const id = $(e.currentTarget).closest(".model_row").find(".model_id").html();
        const model = $("#rails_model").val();
        const i18nModel = I18n.t(`activerecord.models.${model}.one`).toLowerCase();
        display_confirm_modal(I18n.t("modal.title.destroy"),
          I18n.t("model_phrases.are_you_sure.destroy.n.s", { model: i18nModel }),
          that.destroy_model.bind(that, id)
        );
      });
    };

    this.update_status = (
                            id,
                            controller = $("#rails_controller").val(),
                            current_status = $(`#index_table #model_${id} .activate_btn`).length === 0
                          ) => {
      const that = this;

      $.ajax({
        type: "POST",
        url: that.status_path(controller, id, current_status),
        beforeSend: xhr => {
          xhr.setRequestHeader("X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content"));
        },
        dataType: "json",
        success: response => {
          if(response.status === "ok") {
            display_notice(response.message);
            that.update_view(id, response);
          } else {
            display_error(response.message);
          }
        },
        error: () => {
          display_error(I18n.t("error_pages.internal_server_error.title"));
        }
      });
    };

    this.update_view = (
      response,
      model = $("#rails_model").val()
    ) => {
      const target = `tr#model_${response.id} td.status`;

      if(response.activated) {
        $(target).html(
          ServerFunctions.buttons.deactivate(model, response.id)
        );
      }
      else {
        $(target).html(
          ServerFunctions.buttons.activate(model, response.id)
        );
      }
    };

    this.status_path = (controller, id, is_now_active) => {
      if(is_now_active)
        return ServerFunctions.paths.deactivate(controller, id);
      else
        return ServerFunctions.paths.activate(controller, id);
    };

    this.destroy_model = (id) => {
      const that = this;
      const controller = $("#rails_controller").val();

      $.ajax({
        type: "DELETE",
        url: `${ServerFunctions.paths.index(controller)}/${id}`,
        beforeSend: xhr => {
          xhr.setRequestHeader("X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content"));
        },
        dataType: "json",
        success: response => {
          if(response.success) {
            display_notice(response.message);
            that.remove_row(response.model_id);

          } else {
            display_error(response.message);
          }
        },
        error: () => {
          display_error(I18n.t("error_pages.internal_server_error.title"));
        }
      });
    };

    this.remove_row = model_id => {
      $(`#model_${model_id}`).remove();
      const controller = $("#rails_controller").val();

      if($("#index_table tbody tr").length === 1) {
        $(`tr#no_${controller}_row`).removeClass("hidden");
      }
    };

    this.setup_listeners();
    this.setup_filter_panel();
  }

  return IndexCommons;
}());

export default IndexCommons;
