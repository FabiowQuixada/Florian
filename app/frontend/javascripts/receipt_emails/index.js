import { on_page } from './../application'
import { clean_resend_modal, clean_send_test_modal } from './modals'
import ServerFunctions from './../server_functions'

$(() => { if(on_page('receipt_emails', 'index')) receipt_emails_index() });

const receipt_emails_index = () => {
  $('.resend_btn').click( e => {
    const elem = $(e.currentTarget);
    clean_resend_modal();

    const id = elem.closest('.model_row').find('.model_id').text();
    $('#receipt_email_id').val(id);
    $('.modal_maintainer_name').text(elem.closest('.model_row').find('.receipt_maintainer').text());
    $('#resend_email_modal').modal('show');
  });

  $('.send_test_btn').click( e => {
    const elem = $(e.currentTarget);
    clean_send_test_modal();

    const id = elem.closest('.model_row').find('.model_id').text();
    $('#receipt_email_id').val(id);
    $('.modal_maintainer_name').text(elem.closest('.model_row').find('.receipt_maintainer').text());
    $('#send_test_email_modal').modal('show');
  });

  $('#recent_emails_btn').click( () => $('#recent_emails_modal').modal('show'))
}
