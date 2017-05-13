import { on_action } from "./application";
import ServerFunctions from "./../../server_functions";

const attr_values = new Array();

const button = elem => elem.hasClass("btn");
const temp_field = elem => elem.hasClass("temp_field");
const hidden_field = elem => elem.attr("type") !== "hidden";
const status_attr = elem => elem.attr("id") === "model_status";
const has_id = elem => typeof elem.attr("id") !== "undefined";

const has_changed = key => {
  if($(`#${key}`).hasClass("numbers_only") && attr_values[key] === "" && $(`#${key}`).val() === "0")
    return false;

  return attr_values[key] !== $(`#${key}`).val();
};

const go_back = (controller = $("#rails_controller").val()) => {
  window.location = ServerFunctions.paths.index(controller);
};

const handle_back_on_edit = before_submit_or_leave => {
  let any_change = attr_values.filter(has_changed);

  if(typeof before_submit_or_leave === "function") {
    any_change = before_submit_or_leave();
  }

  if(any_change) {
    $("#confirm_back_modal").modal("show");
    $("#modal_back_btn").on("click", () => go_back());
  } else {
    go_back();
  }
};

const save_model_values_on_page_load = () => {
  // Saves the values of the model on page load, so it can be compared to the
  // values when the user goes back, allowing a 'not-saved data' pop-up to display;
  attr_values.length = 0;
  $("input, textarea, select").each((i, field) => {
    const elem = $(field);
    if(!button(elem) && has_id(elem) && !temp_field(elem) &&
        (status_attr(elem) || hidden_field(elem)))
      attr_values[$(field).attr("id")] = $(field).val();
  });
};

export const add_tag_to_field = (field, tag) => {
  const caretPos = document.getElementById(field).selectionStart;
  const textAreaTxt = jQuery(`#${field}`).val();
  jQuery(`#${field}`).val(`${textAreaTxt.substring(0, caretPos)} ${tag} ${textAreaTxt.substring(caretPos)}`);
};

export const init = before_submit_or_leave => {
  if(on_action("form")) {
    save_model_values_on_page_load();

    $("#form_back_btn").on("click", handle_back_on_edit.bind(self, before_submit_or_leave));

    $("#modal_confirm_btn").on("click", () => {
      document.getElementById("main_form").submit();
    });

  } else {
    $(".back_btn").on("click", go_back);
  }
};

$( () => {
  init();
});
