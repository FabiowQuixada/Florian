import React from 'react';
import ReactDOM from 'react-dom';
import { createStore } from 'redux'
import { Provider } from 'react-redux';
import { on_page } from './../support/application'
import { display_confirm_modal } from './../support/modals'
import * as email_module from './../support/email_address_table'
import { add_tag_to_field } from './../support/form_commons'
import I18n from './../../i18n'
import { set_number_of_tabs } from './../support/tab_commons'
import emailsReducer from './../../reducers/emailsReducer';
import EmailAreaContainer from './../../containers/EmailAreaContainer'
import { init } from "./../support/form_commons";

$(() => {
  if(on_page('system_settings', 'index') || on_page('system_settings', 'update'))
    new SystemSettingsIndex();
});

const SystemSettingsIndex = (function() {
  function SystemSettingsIndex() {
    const that = this;
    const email_field_1 = 'pse_recipients_array';
    const email_field_2 = 'pse_private_recipients_array';

    this.setup_listeners = () => {
      $("#add_maintainer_to_re_title_btn").on('click', () => add_tag_to_field('system_setting_re_title', I18n.t('tags.maintainer')));
      $("#add_value_to_re_title_btn").on('click', () => add_tag_to_field('system_setting_re_title', I18n.t('tags.value')));
      $("#add_competence_to_re_title_btn").on('click', () => add_tag_to_field('system_setting_re_title', I18n.t('tags.competence')));
      $("#add_maintainer_to_re_body_btn").on('click', () => add_tag_to_field('system_setting_re_body', I18n.t('tags.maintainer')));
      $("#add_value_to_re_body_btn").on('click', () => add_tag_to_field('system_setting_re_body', I18n.t('tags.value')));
      $("#add_competence_to_re_body_btn").on('click', () => add_tag_to_field('system_setting_re_body', I18n.t('tags.competence')));

      $("#add_competence_to_pse_body_btn").on('click', () => add_tag_to_field('system_setting_pse_body', I18n.t('tags.competence')));
      $("#add_competence_to_pse_title_btn").on('click', () => add_tag_to_field('system_setting_pse_title', I18n.t('tags.competence')));

      $('#receipt_title_tag_help_btn, #pse_title_tag_help_btn, #pse_body_tag_help_btn ').click( () =>
          display_confirm_modal(I18n.t('modal.title.info'), I18n.t('user_help_messages.tag_buttons')));

      $("body").on("submit", "#main_form", () => {
        that.before_submit_or_leave();
      });

      email_module.setup_listeners(email_field_1);
      email_module.setup_listeners(email_field_2);
    }

    this.before_submit_or_leave = () => {
      $('#system_setting_pse_recipients_array').val(
        email_module.formated_recipients('pse_recipients_array'));
      $('#system_setting_pse_private_recipients_array').val(
        email_module.formated_recipients('pse_private_recipients_array'));

      return email_module.new_recipients(email_field_1) || email_module.new_recipients(email_field_2);
    };

    this.setup_view_components = () => {
      ReactDOM.render(
        <Provider store={createStore(emailsReducer)}>
          <EmailAreaContainer
            model="system_setting"
            field_name={email_field_1} />
        </Provider>,
        document.getElementById(`${email_field_1}_area`)
      );

      ReactDOM.render(
        <Provider store={createStore(emailsReducer)}>
          <EmailAreaContainer
            model="system_setting"
            field_name={email_field_2} />
        </Provider>,
        document.getElementById(`${email_field_2}_area`)
      );
    }

    init(this.before_submit_or_leave);
    set_number_of_tabs('main', 3);
    this.setup_listeners();
    this.setup_view_components();
  };

  return SystemSettingsIndex;
}());

export default SystemSettingsIndex;
