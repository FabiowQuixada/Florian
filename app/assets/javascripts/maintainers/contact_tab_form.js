$(() => { if(on_page('maintainers', 'form')) maintainers_contact_tab_form() });

let load_contact = null;
let build_contact = null;
let validate_contact = null;
let at_least_one_field_filled = null;
let clean_contact_fields = null;
let add_contact = null;

const maintainers_contact_tab_form = () => {
  // Temporary contacts have negative id;
  let transient_contacts = 0;
  let loaded_contact_id = null;
  let contact_temp_id = -1;

  const new_contacts = () => transient_contacts > 0

  load_contact = id => {
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
  build_contact = () => {
    const id = loaded_contact_id ? (contact_temp_id = contact_temp_id + 1) : loaded_contact_id;
    const name = $('#temp_contact_name').val();
    const position = $('#temp_contact_position').val();
    const email_address = $('#temp_contact_email_address').val();
    const telephone = $('#temp_contact_telephone').val();
    const celphone = $('#temp_contact_celphone').val();
    const fax = $('#temp_contact_fax').val();

    return {
      id,
      name,
      position,
      email_address,
      telephone,
      celphone,
      fax
    }
  }

  at_least_one_field_filled = (contact) => (
    contact.name !== "" || 
    contact.position !== "" || 
    contact.email_address !== "" || 
    contact.telephone !== "" || 
    contact.celphone !== "" || 
    contact.fax !== ""
  )

  validate_contact = (contact) => {
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

  add_contact = (contact) => {
    if(validate_contact(contact)) {
      transient_contacts += 1;

      if(loaded_contact_id) {

        // View;
        $(`#contact_${loaded_contact_id} .contact_name`).text(contact.name);
        $(`#contact_${loaded_contact_id} .contact_position`).text(contact.position);
        $(`#contact_${loaded_contact_id} .contact_email_address`).text(contact.email);
        $(`#contact_${loaded_contact_id} .contact_telephone`).text(contact.telephone);
        $(`#contact_${loaded_contact_id} .contact_celphone`).text(contact.celphone);
        $(`#contact_${loaded_contact_id} .contact_fax`).text(contact.fax);

        // Params;
        $(`#maintainer_contacts_attributes_${loaded_contact_id}_name`).val(contact.name);
        $(`#maintainer_contacts_attributes_${loaded_contact_id}_position`).val(contact.position);
        $(`#maintainer_contacts_attributes_${loaded_contact_id}_email_address`).val(contact.email);
        $(`#maintainer_contacts_attributes_${loaded_contact_id}_telephone`).val(contact.telephone);
        $(`#maintainer_contacts_attributes_${loaded_contact_id}_celphone`).val(contact.celphone);
        $(`#maintainer_contacts_attributes_${loaded_contact_id}_fax`).val(contact.fax);
      } else {
        $.ajax({
          url: Constants.paths.contact_row_maintainers, 
          data: { contact },
          success: result => $('#contacts_table > tbody:last-child').append(result)
        });

        contact_temp_id -= 1;
      }

      clean_contact_fields();
      $('#no_contacts_row').addClass('hidden');
    }
  }

  clean_contact_fields = () => {
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
  
  $('body').on('click', '.edit_contact_btn', e => {
    const elem = $(e.currentTarget);
    load_contact(elem.closest('.contact_row').find('.contact_id').text())
  });

  $('#add_contact_btn').on('click', () => {
    contact = build_contact();
    add_contact(contact);
  });

  $('body').on('click', '.remove_contact_btn', e => {
    const elem = $(e.currentTarget);
    const id = elem.closest('.contact_row').find('.contact_id').text();

    $(`#contact_${id}`).remove();

    transient_contacts -= 1;

    if(document.getElementById("contacts_table").rows.length == 2)
      $('#no_contacts_row').removeClass('hidden');

    if(id > 0) {
      $('#maintainer_contacts_to_be_deleted').val(`${$('#maintainer_contacts_to_be_deleted').val()}${id},`);
    }

    clean_contact_fields();
  });


  $('#cancel_contact_edition_btn').on('click', clean_contact_fields);
}