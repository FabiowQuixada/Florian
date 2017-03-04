let any_change = false;

const validate_email = email => (
  /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
      .test(email)
  )

const display_form_errors = message => {
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