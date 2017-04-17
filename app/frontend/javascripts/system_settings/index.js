import { on_page } from './../application'
import { display_confirm_modal } from './../others/modals'
import { new_recipients, setup_listeners_for_email_field, formated_recipients } from './../others/email_address_table'
import { add_tag_to_field } from './../form_commons'
import I18n from './../i18n'
import { set_number_of_tabs } from './../tab_commons'

$(() => { if(on_page('system_settings', 'index')) system_settings_index() });

const system_settings_index = () => {
  const email_field_1 = 'pse_recipients_array';
  const email_field_2 = 'pse_private_recipients_array';

  set_number_of_tabs('main', 3);

  $("#add_maintainer_to_re_title_btn").on('click', () => add_tag_to_field('system_setting_re_title', I18n.t('tags.maintainer')));
  $("#add_value_to_re_title_btn").on('click', () => add_tag_to_field('system_setting_re_title', I18n.t('tags.value')));
  $("#add_competence_to_re_title_btn").on('click', () => add_tag_to_field('system_setting_re_title', I18n.t('tags.competence')));
  $("#add_maintainer_to_re_body_btn").on('click', () => add_tag_to_field('system_setting_re_body', I18n.t('tags.maintainer')));
  $("#add_value_to_re_body_btn").on('click', () => add_tag_to_field('system_setting_re_body', I18n.t('tags.value')));
  $("#add_competence_to_re_body_btn").on('click', () => add_tag_to_field('system_setting_re_body', I18n.t('tags.competence')));

  $("#add_competence_to_pse_body_btn").on('click', () => add_tag_to_field('system_setting_pse_body', I18n.t('tags.competence')));
  $("#add_competence_to_pse_title_btn").on('click', () => add_tag_to_field('system_setting_pse_title', I18n.t('tags.competence')));

  $('#receipt_title_tag_help_btn, #pse_title_tag_help_btn, #pse_body_tag_help_btn ').click( e => 
      display_confirm_modal(I18n.t('modal.title.info'), I18n.t('user_help_messages.tag_buttons')));

  const before_submit_or_leave = () => {
    if(new_recipients(email_field_1) || new_recipients(email_field_2)) {
      window.any_changes = true;
    }

    $('#system_setting_pse_recipients_array').val(formated_recipients('pse_recipients_array'));
    $('#system_setting_pse_private_recipients_array').val(formated_recipients('pse_private_recipients_array'));
  }

  $('#main_form').on('submit', e => before_submit_or_leave());

  setup_listeners_for_email_field(email_field_1);
  setup_listeners_for_email_field(email_field_2);
}
