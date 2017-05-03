import { display_form_errors, validate_email } from './../form_commons.js'
import { hide_all_messages } from './../message_area.js'
import Constants from './../server_constants.js'
import I18n from './../i18n.js'

/**

  This file is the e-mail table partial javascript counter-part. You have to take care of a few things:

  Let's say you have a model M with a string attribute 'email_array'. Then you need to make the following
  call after page load so that event handlers are attached to view buttons:

    setup_listeners_for_email_field('email_array');

  Also, to check if there are any new e-mails added, simply call:

    new_recipients('email_array')

*/

let temp_ids;

const next_temp_id = field => {
  if (typeof temp_ids === 'undefined') {
    temp_ids = {};
  }

  if (typeof temp_ids[field] === 'undefined') {
    temp_ids[field] = -1;
  }

  return temp_ids[field]--;
}

export const new_recipients = field => {
  let new_recipient = false;

  $(`#${field}_table td.contact_id`).each((index, td) => {
    if(parseInt($(td).text()) < 0)
      new_recipient = true;
  });

  return new_recipient;
}

const already_present = (email_address, field) => {
  let result = false;

  $(`#${field}_recipients_table > tbody > tr`).each((i, elem) => {
    if($(elem).find('.recipient_email').html() === email_address) {
      result = true;
    }
  })

  return result;
}

export const formated_recipients = (id = field_name) => {
  let array = '';

  $(`#${id}_recipients_table > tbody > tr`).each((i, elem) => {
    array = array.concat($(elem).find('.recipient_email').html() + ', ');
  })

  return array.substring(0, array.length - 2);
}

const clean_email_fields = field => $(`#${field}_new_recipient_field`).val('')

export const setup_listeners_for_email_field = field_name => {
  $('body').on('click', `.${field_name}_remove_recipient_btn`, e => {
    const elem = $(e.currentTarget);
    const id = elem.closest('.email_recipient').find('.recipient_id').text();

    $(`#${field_name}_email_address_${id}`).fadeOut('slow', () => {
        $(`#${field_name}_email_address_${id}`).remove();
    });
  });

  $(`#${field_name}_add_recipient_btn`).on('click', () => {
    const email_address = $(`#${field_name}_new_recipient_field`).val();

    if (!$(`#${field_name}_new_recipient_field`).val()) {
        display_form_errors(I18n.t('alert.email.fill_a_recipient'));
    } else if(already_present(email_address, field_name)) {
        display_form_errors(I18n.t('alert.email.duplicated_recipient'));

    } else if (validate_email(email_address)) {
      $.ajax({
        url: Constants.paths.email_row_helpers, 
        data: { 
          email_address: email_address, 
          index: next_temp_id(field_name), 
          field_name: field_name
        },
        success: result => {
          $(`#${field_name}_recipients_table > tbody:last-child`).append(result);
        }
      });

      hide_all_messages();
      clean_email_fields(field_name);
    } else {
      display_form_errors(I18n.t('alert.email.invalid_recipient'));
    }
  });
}
