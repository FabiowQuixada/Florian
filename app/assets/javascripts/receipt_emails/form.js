import { on_page, escape_html } from './../application.js'
import Constants from './../server_constants.js'
import { new_recipients, setup_listeners_for_email_field, formated_recipients } from './../others/email_address_table.js'
import I18n from './../i18n.js'

$(() => { if(on_page('receipt_emails', 'form')) receipt_emails_form() });

let before_submit_or_leave;

const receipt_emails_form = () => {
  const email_field = 'recipients_array';

  if(on_page('receipt_emails', 'edit')) {
    $('.resend_btn').click( e => {
      const id = $("#receipt_email_id").val();
      const company_name = $('#receipt_email_maintainer > option[selected="selected"]').text();

      clean_resend_modal();
      $('#resend_email_form').get(0).setAttribute('action', 
        ServerFunctions.paths.resend_receipt_email(id));
      $('.modal_maintainer_name').text(company_name);
      $('#resend_email_modal').modal('show');
    });

    $('.send_test_btn').click( e => {
      const id = $("#receipt_email_id").val();
      const company_name = $('#receipt_email_maintainer > option[selected="selected"]').text();
      
      clean_send_test_modal();
      $('#send_test_email_form').get(0).setAttribute('action', ServerFunctions.paths.send_test_receipt_email(id));
      $('.modal_maintainer_name').text(company_name);
      $('#send_test_email_modal').modal('show');
    });
  }

  $('#receipt_email_title').val(escape_html(Constants.system_settings.receipt_title));


  before_submit_or_leave = () => {
    if(new_recipients(email_field)) {
      any_changes = true;
    }

    $('#receipt_email_email_field').val(formated_recipients(email_field));
  }

  $('#body_tag_help_btn').click( e => {
    display_confirm_modal(I18n.t('modal.title.info'), I18n.t('user_help_messages.tag_buttons'));
  });

  $('#main_form').on('submit', e => {
    before_submit_or_leave();

    if(!validate_tag_fields()) {
      $('#warning_save_modal').modal('show');
      e.preventDefault();
      return;
    }
  });

  const validate_tag_fields = () => !contains_all_tags($('#receipt_email_body').val())

  const contains_all_tags = text => (
    text.indexOf(I18n.t('tags.maintainer')) == -1 || text.indexOf(I18n.t('tags.value')) == -1 || text.indexOf(I18n.t('tags.competence')) == -1
  )

  $("#add_maintainer_to_body_btn").on('click', () => add_tag_to_field('receipt_email_body', I18n.t('tags.maintainer')));
  $("#add_value_to_body_btn").on('click', () => add_tag_to_field('receipt_email_body', I18n.t('tags.value')));
  $("#add_competence_to_body_btn").on('click', () => add_tag_to_field('receipt_email_body', I18n.t('tags.competence')));

  setup_listeners_for_email_field(email_field);
}