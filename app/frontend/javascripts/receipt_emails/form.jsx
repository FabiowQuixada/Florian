import React from 'react';
import ReactDOM from 'react-dom';
import { createStore } from 'redux'
import { on_page, escape_html } from './../application'
import { Provider } from 'react-redux';
import EmailAreaContainer from './../redux/containers/EmailAreaContainer'
import { clean_resend_modal, clean_send_test_modal } from './modals'
import Constants from './../server_constants'
import emailsReducer from './../redux/reducers/emailsReducer';
import { new_recipients, } from './../others/email_address_table'
import I18n from './../i18n'
import { formated_recipients } from '../others/email_address_table'
import { init, add_tag_to_field } from './../form_commons'

$(() => { if(on_page('receipt_emails', 'form')) new ReceiptEmailsForm() });

const ReceiptEmailsForm = (function() {
  function ReceiptEmailsForm() {
    const self = this;
    
    this.before_submit_or_leave = () => {
      const email_field = 'recipients_array';
      $(`#receipt_email_${email_field}`).val(formated_recipients(email_field));

      if(new_recipients(email_field)) {
        return true;
      }

      return false;
    }

    this.validate_tag_fields = () => !this.contains_all_tags($('#receipt_email_body').val())

    this.contains_all_tags = text => (
      text.indexOf(I18n.t('tags.maintainer')) == -1 ||
      text.indexOf(I18n.t('tags.value')) == -1 ||
      text.indexOf(I18n.t('tags.competence')) == -1
    )

    this.setup_listeners = () => {
      $("#add_maintainer_to_body_btn").on('click', () => add_tag_to_field('receipt_email_body', I18n.t('tags.maintainer')));
      $("#add_value_to_body_btn").on('click', () => add_tag_to_field('receipt_email_body', I18n.t('tags.value')));
      $("#add_competence_to_body_btn").on('click', () => add_tag_to_field('receipt_email_body', I18n.t('tags.competence')));
      
      $('#body_tag_help_btn').click( e => {
        display_confirm_modal(I18n.t('modal.title.info'), I18n.t('user_help_messages.tag_buttons'));
      });

      $('#main_form').on('submit', e => {
        self.before_submit_or_leave();

        if(!self.validate_tag_fields()) {
          e.preventDefault();
          $('#warning_save_modal').modal('show');
          return;
        }
      });

      if(on_page('receipt_emails', 'edit')) {
        $('.resend_btn').click( e => {
          const id = $("#receipt_email_id").val();
          const company_name = $('#receipt_email_maintainer > option[selected="selected"]').text();

          clean_resend_modal();
          $('.modal_maintainer_name').text(company_name);
          $('#resend_email_modal').modal('show');
        });

        $('.send_test_btn').click( e => {
          const id = $("#receipt_email_id").val();
          const company_name = $('#receipt_email_maintainer > option[selected="selected"]').text();
          
          clean_send_test_modal();
          $('.modal_maintainer_name').text(company_name);
          $('#send_test_email_modal').modal('show');
        });
      }
    }

    this.setup_view_components = () => {
      $('#receipt_email_title').val(escape_html(Constants.system_settings.receipt_title));
      this.setup_listeners();

      ReactDOM.render(
        <Provider store={createStore(emailsReducer)}>
          <EmailAreaContainer 
            model="receipt_email"
            label={ I18n.t("activerecord.attributes.receipt_email.recipients_array") } />
        </Provider>,
        document.getElementById("email_area")
      );
    }

    init(this.before_submit_or_leave);
    this.setup_listeners();
    this.setup_view_components();
  }

  return ReceiptEmailsForm;
}());

export default ReceiptEmailsForm;
