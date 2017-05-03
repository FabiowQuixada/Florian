import { on_action, to_top } from './application.js'
import { hide_all_messages } from './message_area.js'

let any_change = false;
let attr_values = new Array();
let before_submit_or_leave;

// TODO: Not the best way of getting the model name;
const go_back = (model_name = $('body').attr('class').split(' ')[0]) => {
  window.location = ServerFunctions.paths.index(model_name);
}

export const display_form_errors = message => {
  let result = '';

  if (Object.prototype.toString.call(message) === '[object Array]') {
    result = msg_as_html_ul(message);
  } else {
    result = message;
  }

  hide_all_messages();
  to_top();
  $('#form_error_messages').html(result);
  $('#form_error_box').removeClass('hidden');
}

export const add_tag_to_field = (field, tag) => {
  const caretPos = document.getElementById(field).selectionStart;
  const textAreaTxt = jQuery(`#${field}`).val();
  jQuery(`#${field}`).val(`${textAreaTxt.substring(0, caretPos)} ${tag} ${textAreaTxt.substring(caretPos)}`);
}

$(() => {
  if(on_action('form')) {
    
    const has_changed = key => {
      if($(`#${key}`).hasClass("numbers_only") && attr_values[key] === "" && $(`#${key}`).val() === "0")
        return false;

      return attr_values[key] != $(`#${key}`).val();
    }

    const handle_back_on_edit = () => {

      any_change = false;

      if(typeof before_submit_or_leave === "function") {
        before_submit_or_leave();
      }

      // const changed_values_list = [];

      if(!any_change) {
        for (let key in attr_values) {
          if(has_changed(key)) {
            // changed_values_list.push(key);
            any_change = true;
          }
        }
      }

      if(any_change) {
        $('#confirm_back_modal').modal('show');
        $('#modal_back_btn').on('click', () => go_back());
      } else {
        go_back();
      }
    }


    const button = elem => elem.hasClass('btn')
    const temp_field = elem => elem.hasClass('temp_field')
    const hidden_field = elem => elem.attr('type') !== 'hidden'
    const status_attr = elem => elem.attr('id') === 'model_status'
    const has_id = elem => typeof elem.attr('id') !== 'undefined'

    // Saves the values of the model on page load, so it can be compared to the values when the user goes back, allowing a 'not-saved data' pop-up to display;
    attr_values = new Array();
    $('input, textarea, select').each((i, field) => {
      const elem = $(field);
      if(!button(elem) && has_id(elem) && !temp_field(elem) && (status_attr(elem) || hidden_field(elem)))
        attr_values[$(field).attr('id')] = $(field).val();
    })

    $('#form_back_btn').on('click', handle_back_on_edit);

  } else {
    $( () => $('.back_btn').on('click', () => go_back()) );
  }
});

$('#modal_confirm_btn').on('click', () => {
  document.getElementById("main_form").submit();
});
