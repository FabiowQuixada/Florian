import { on_controller } from './../application'

$(() => { if(on_controller('receipt_emails')) receipt_emails_modals() });

export const clean_resend_modal = () => $('#resend_competence').val(default_competence());
export const clean_send_test_modal = () => $('#send_test_competence').val(default_competence());
const default_competence = () => `${("0" + (new Date().getMonth()+1)).slice(-2)}/${new Date().getFullYear()}`

const receipt_emails_modals = () => {
  $('#modal_save_btn').on('click', () => document.getElementById("main_form").submit())

  $("#send_test_email_form").on("ajax:success", (e, data, status, xhr) => {
    display_notice(data.message);
    add_history_item(data);
  }).on("ajax:error", (e, xhr, status, error) => parse_json_errors(xhr.responseText));

  $("#resend_email_form").on("ajax:success", (e, data, status, xhr) => {
    display_notice(data.message);
    add_history_item(data);
    add_recent_email(data);
  }).on("ajax:error", (e, xhr, status, error) => parse_json_errors(xhr.responseText));

  $('#resend_email_form').submit( e => {
    display_info(I18n.t('alert.email.resending'));

    $('#resend_email_modal').modal('hide');

    if(on_action('edit')) {
      for (let key in attr_values) {
        add_hidden_field('resend_email_form', key, $(`#${key}`).val());
      }

      add_hidden_field('resend_email_form', 'active', $('#model_status').val());
    }
  });

  $('#send_test_email_form').submit( e => {
    display_info(I18n.t('alert.email.sending_test'));

    $('#send_test_email_modal').modal('hide');

    if(on_action('edit')) {
      for (let key in attr_values) {
        add_hidden_field('send_test_email_form', key, $(`#${key}`).val());
      }

      add_hidden_field('send_test_email_form', 'active', $('#model_status').val());
    }
  });

  const add_history_item = response => {
    $('#history_table > tbody:last-child').append(
      `<tr>
        <td>${response.model.date}<\/td>
        <td>${response.model.value}<\/td>
        <td>${response.model.type}<\/td>
        <td>${response.model.user}<\/td>
      <\/tr>`
    );
  }

  const add_recent_email = response => {
    $('#recent_emails_table > tbody:last-child').append(
      `<tr>
        <td>${response.model.date}<\/td>
        <td>${response.model.maintainer}<\/td>
        <td>${response.model.type}<\/td>
      <\/tr>`
    );
  }

  const add_hidden_field = (form_id, key, value) => {
    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = `receipt_email[${key}]`;
    input.value = value;
    document.getElementById(form_id).appendChild(input);
  }
}