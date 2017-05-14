/**

  This file is the e-mail table partial javascript counter-part. You have to take care of a few things:

  Let's say you have a model M with a string attribute 'email_array'. Then you need to make the following
  call after page load so that event handlers are attached to view buttons:

    setup_listeners_for_email_field('email_array');

  Also, to check if there are any new e-mails added, simply call:

    new_recipients('email_array')

*/

export const new_recipients = field => {
  let new_recipient = false;

  $(`#${field}_recipients_table tbody td.is_persisted`).each((index, td) => {
    if($(td).text() === "false")
      new_recipient = true;
  });

  return new_recipient;
}

export const formated_recipients = field_name => {
  let array = '';

  $(`#${field_name}_recipients_table > tbody > tr`).each((i, elem) => {
    array = array.concat($(elem).find('.recipient_email').html() + ', ');
  });

  return array.substring(0, array.length - 2);
}

export const setup_listeners_for_email_field = field_name => {
  $('body').on('click', `.${field_name}_remove_recipient_btn`, e => {
    const elem = $(e.currentTarget);
    const id = elem.closest('.email_recipient').find('.recipient_id').text();

    $(`#${field_name}_email_address_${id}`).fadeOut('slow', () => {
        $(`#${field_name}_email_address_${id}`).remove();
    });
  });
}
