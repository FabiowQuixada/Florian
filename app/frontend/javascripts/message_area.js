import I18n from './i18n'
import Constants from './server_constants'

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

export const display_notice = message => {
  hide_all_messages();
  to_top();
  $('#global_notice_massages').html(message);
  $('#global_notice_box').removeClass('hidden');
}

export const display_warning = message => {
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

export const hide_errors = () => {
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

export const parse_json_errors = xhr => {
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

export const msg_as_html_ul = message => {
  let result = '<ul>';

  for (let i = 0; i < message.length; i++)
    result += `<li>${message[i]}<\/li>`;

  result += '<\/ul>';

  return result;
}

export const is_empty = message => (
  (typeof message !== 'string' && Object.prototype.toString.call(message) !== '[object Array]') || message.length === 0
)

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

  if ($('#rails_env').val() === 'showcase' && $('body').attr('class') === 'sessions new') {
    const user_number = Constants.showcase_env.user_numbers[Math.floor(Math.random() * Constants.showcase_env.user_numbers.length)];
    const email = `${Constants.showcase_env.user}_${user_number}@florian.com`;

    display_hideless_warning(I18n.t('showcase.login_info', {
      showcase_email: email,
      showcase_password: Constants.showcase_env.password
    }));
  }
});
