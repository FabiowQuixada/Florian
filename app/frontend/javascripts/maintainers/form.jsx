import { on_page } from './../application'
import { set_number_of_tabs } from './../tab_commons'
import { init } from './../form_commons'

$(() => { if(on_page('maintainers', 'form')) maintainers_form() });

const maintainers_form = () => {
  const new_donations = () => {
    let new_donation = false;

    $("#donations_table .server-communication-data input.donation_id").each((index, input) => {
      if(parseInt($(input).val()) < 0)
        new_donation = true;
    });

    return new_donation;
  }

  const new_contacts = () => {
    let new_contact = false;

    $("#contacts_table .server-communication-data input.contact_id").each((index, td) => {
      if(parseInt($(td).val()) < 0)
        new_contact = true;
    });

    return new_contact;
  }

  const before_submit_or_leave = () => new_donations() || new_contacts()

  init(before_submit_or_leave);

  set_number_of_tabs('main', 3);

  const update_fields_by_entity_type = () => {
    $('.person_area').addClass('hidden');
    $('.maintainer_area').addClass('hidden');

    if($('#maintainer_entity_type').val() == "company") {
      $('.maintainer_area').removeClass('hidden');
    } else if($('#maintainer_entity_type').val() == "person") {
      $('.person_area').removeClass('hidden');
    }
  }

  $('#main_form').on('submit', e => {
    const errors = new Array();
    const email = $('#maintainer_email_address').val();

    before_submit_or_leave();

    if(email && !validate_email(email)) {
      errors.push(I18n.t('alert.email.invalid_recipient'));
    }

    if(errors.length > 0) {
      e.preventDefault();
      display_form_errors(errors);
    }
  });

  update_fields_by_entity_type();
}
