$(document).ready( () => {
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
});

const before_submit_or_leave = () => {
  any_change = false;

  if(typeof new_donations === "function" && new_donations()) {
    any_change = true;
  }

  if(transient_contacts > 0) {
    any_change = true;
  }
}

const update_fields_by_entity_type = () => {
  $('.person_area').addClass('hidden');
  $('.maintainer_area').addClass('hidden');

  if($('#maintainer_entity_type').val() == "company") {
    $('.maintainer_area').removeClass('hidden');
  } else if($('#maintainer_entity_type').val() == "person") {
    $('.person_area').removeClass('hidden');
  }
}
