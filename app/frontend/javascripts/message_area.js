export const display_error = (message, error_box_id = 'global') => {
  let result = '';

  if (Object.prototype.toString.call(message) === '[object Array]') {
    result = msg_as_html_ul(message);
  } else {
    result = message;
  }

  hide_all_messages();
  $(`#${error_box_id}_error_messages`).html(result);
  $(`#${error_box_id}_error_box`).removeClass('hidden');
}

export const display_info = message => {
  hide_all_messages();
  to_top();
  $('#global_info_massages').html(message);
  $('#global_info_box').removeClass('hidden');
}

const display_notice = message => {
  hide_all_messages();
  to_top();
  $('#global_notice_massages').html(message);
  $('#global_notice_box').removeClass('hidden');
}

const display_warning = message => {
  hide_all_messages();
  to_top();
  $('#global_warning_massages').html(message);
  $('#global_warning_box').removeClass('hidden');
}

const display_hideless_warning = message => {
  $('#global_hideless_warning_massages').html(message);
  $('#global_hideless_warning_box').removeClass('hidden');
}

const hide_info = () => {
  $('#global_info_massages').html('');
  $('#global_info_box').addClass('hidden');
}

const hide_notice = () => {
  $('#global_notice_massages').html('');
  $('#global_notice_box').addClass('hidden');
}

const hide_errors_from_box = error_box_id => {
  $(`#${error_box_id}_error_messages`).html('');
  $(`#${error_box_id}_error_box`).addClass('hidden');
}

const hide_errors = () => {
  $('#global_error_messages').html('');
  $('#global_error_box').addClass('hidden');

  if($("#form_error_messages").length && $("#form_error_box").length) {
    $('#form_error_messages').html('');
    $('#form_error_box').addClass('hidden');
  }
}

export const hide_all_messages = () => {
  hide_info();
  hide_notice();
  hide_errors();
}

const parse_json_errors = xhr => {
  try {
    const json_obj = jQuery.parseJSON(xhr);

    const output = new Array();
    for (let i in json_obj)
      output.push(json_obj[i]);

    display_error(output);
  }
  catch(e) {
    if (typeof xhr === 'string' || xhr instanceof String)
      return display_error(xhr);
  }
}

const msg_as_html_ul = message => {
  let result = '<ul>';

  for (let i = 0; i < message.length; i++)
    result += `<li>${message[i]}<\/li>`;

  result += '<\/ul>';

  return result;
}

export const to_top = () => {
  $('html, body').animate({
    scrollTop: $("body").offset().top
  }, 1000);
}

$(() => {
  // Handles alert hide, instead of dismiss;
  $("[data-hide]").on("click", e => {
    const elem = e.target;
    $(elem).closest(`.${$(elem).attr("data-hide")}`).addClass('hidden');
  });
});
