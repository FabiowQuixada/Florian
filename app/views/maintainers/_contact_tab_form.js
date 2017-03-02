/** 
  This file is a workaround because I din't get Karma to precompile erb files.
  Here are the non-erb-dependent functions;
**/

// Temporary contacts have negative id;
let transient_contacts = 0;
let loaded_contact_id = null;
let contact_temp_id = -1;

const load_contact = id => {
  loaded_contact_id = id;

  $('#cancel_contact_edition_btn').removeClass('hidden');
  $('#add_contact_btn').text(I18n.t('helpers.action.update'));
  $('#contact_panel_header').text(I18n.t('helpers.maintainer.edit_contact'));

  $('#temp_contact_name').val($(`#contact_${id} .contact_name`).text());
  $('#temp_contact_position').val($(`#contact_${id} .contact_position`).text());
  $('#temp_contact_email_address').val($(`#contact_${id} .contact_email_address`).text());
  $('#temp_contact_telephone').val($(`#contact_${id} .contact_telephone`).text());
  $('#temp_contact_celphone').val($(`#contact_${id} .contact_celphone`).text());
  $('#temp_contact_fax').val($(`#contact_${id} .contact_fax`).text());
}

// Buils a contact based on user input;
const build_contact = () => {
  const name = $('#temp_contact_name').val();
  const position = $('#temp_contact_position').val();
  const email = $('#temp_contact_email_address').val();
  const telephone = $('#temp_contact_telephone').val();
  const celphone = $('#temp_contact_celphone').val();
  const fax = $('#temp_contact_fax').val();

  return {
    id: contact_temp_id,
    name: name,
    position: position,
    email_address: email,
    telephone: telephone,
    celphone: celphone,
    fax: fax
  }
}

const at_least_one_field_filled = (contact) => (
  contact.name !== "" || 
  contact.position !== "" || 
  contact.email_address !== "" || 
  contact.telephone !== "" || 
  contact.celphone !== "" || 
  contact.fax !== ""
)

const validate_contact = (contact) => {
  const errors = new Array();

  if(!at_least_one_field_filled(contact)) {
    errors.push(I18n.t('errors.contact.all_empty'));
  }

  if(contact.email_address && !validate_email(contact.email_address)) {
    errors.push(I18n.t('alert.email.invalid_recipient'));
  }

  display_error(errors, 'contact');

  return errors.length === 0;
}

const clean_contact_fields = () => {
  $('#temp_contact_name').val('');
  $('#temp_contact_position').val('');
  $('#temp_contact_email_address').val('');
  $('#temp_contact_telephone').val('');
  $('#temp_contact_celphone').val('');
  $('#temp_contact_fax').val('');

  loaded_contact_id = null;
  $('#cancel_contact_edition_btn').addClass('hidden');
  $('#add_contact_btn').text(I18n.t('helpers.action.add'));
  $('#contact_panel_header').text(I18n.t('helpers.maintainer.new_contact'));

  hide_errors_from_box('contact');
}