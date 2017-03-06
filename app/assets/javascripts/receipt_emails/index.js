$(() => { if(on_page('receipt_emails', 'index')) receipt_emails_index() });

const receipt_emails_index = () => {
  $('.resend_btn').click( e => {
    const elem = $(e.currentTarget);
    clean_resend_modal();

    const id = elem.closest('.model_row').find('.model_id').text();
    $('#resend_email_id').val(id);
    $('#resend_email_form').get(0).setAttribute('action', ServerFunctions.paths.resend_receipt_email(id));
    $('.modal_maintainer_name').text(elem.closest('.model_row').find('.receipt_maintainer').text());
    $('#resend_email_modal').modal('show');
  });

  $('.send_test_btn').click( e => {
    const elem = $(e.currentTarget);
    clean_send_test_modal();

    const id = elem.closest('.model_row').find('.model_id').text();
    $('#send_test_email_id').val(id);
    $('#send_test_email_form').get(0).setAttribute('action', ServerFunctions.paths.send_test_receipt_email(id));
    $('.modal_maintainer_name').text(elem.closest('.model_row').find('.receipt_maintainer').text());
    $('#send_test_email_modal').modal('show');
  });

  $('#recent_emails_btn').click( e => $('#recent_emails_modal').modal('show'))
}