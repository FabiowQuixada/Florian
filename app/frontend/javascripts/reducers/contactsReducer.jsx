import I18n from './../i18n'
import { ADD, UPDATE, LOAD_TO_FORM, REMOVE, CANCEL_EDITION, LOAD_LIST_FROM_SERVER } from './../constants/contactsConstants';
import { EDIT_FIELD, CLEAN_ERRORS } from './../constants/generalConstants';
import { validate_email } from './../pages/support/application.js'
import ContactFactory from './../factories/ContactFactory.js'

if(!global._babelPolyfill) {
  require('babel-polyfill');
}

let contactList;
const errors = new Array();
const initial_state = {
  on_edit: false,
  errors: [],
  loaded_contact: ContactFactory.empty(),
  rows: []
};

const valid_phone = phone => (!phone || (phone && !phone.includes('_')))

const validate = contact => {
  errors.length = 0;

  if(!at_least_one_field_filled(contact)) {
    errors.push(I18n.t('errors.contact.all_empty'));
  }

  if(contact.email_address && !validate_email(contact.email_address)) {
    const attribute = I18n.t('activerecord.attributes.contact.email_address');
    errors.push(I18n.t('errors.messages.invalid', { attribute: attribute }));
  }

  if(!valid_phone(contact.telephone)) {
    const attribute = I18n.t('activerecord.attributes.contact.telephone');
    errors.push(I18n.t('errors.messages.invalid', { attribute: attribute }));
  }
  
  if(!valid_phone(contact.celphone)) {
    const attribute = I18n.t('activerecord.attributes.contact.celphone')
    errors.push(I18n.t('errors.messages.invalid', { attribute: attribute }));
  }

  if(!valid_phone(contact.fax)) {
    const attribute = I18n.t('activerecord.attributes.contact.fax')
    errors.push(I18n.t('errors.messages.invalid', { attribute: attribute }));
  }

  return errors.length === 0;
}

const at_least_one_field_filled = contact => (
  contact.name !== "" || 
  contact.position !== "" || 
  contact.email_address !== "" || 
  contact.telephone !== "" || 
  contact.celphone !== "" || 
  contact.fax !== ""
)

const add_contact_to_deleted_list = contact => {
  if(contact.id > 0) {
    $('#maintainer_contacts_to_be_deleted').val(
      `${$('#maintainer_contacts_to_be_deleted').val()}${contact.id},`
    );
  }
}

const contacts = (state = initial_state, action) => {
  switch (action.type) {
    case CLEAN_ERRORS:
      return Object.assign({}, state, {
        errors: []
      });
    case EDIT_FIELD:
      return Object.assign({}, state, {
        loaded_contact: Object.assign({}, state.loaded_contact, {
          [action.field]: action.value
        })
      });
    case LOAD_LIST_FROM_SERVER:
      return Object.assign({}, state, {
        rows: action.rows
      });
    case ADD:
      if(validate(action.contact)) {
        return Object.assign({}, state, {
          on_edit: false,
          errors: [],
          loaded_contact: ContactFactory.empty(),
          rows: [
            ...state.rows,
            action.contact
          ]
        });
      } else {
        return Object.assign({}, state, {
          errors: errors
        });
      }
    case UPDATE:
      if(validate(action.contact)) {
        return Object.assign({}, state, {
          on_edit: false,
          errors: [],
          loaded_contact: ContactFactory.empty(),
          rows: state.rows.map(c => {
            if(c.id !== action.contact.id) {
              return c;
            }

            return action.contact;
          })
        });
      } else {
        return Object.assign({}, state, {
          errors: errors
        });
      }
    case LOAD_TO_FORM:
      return Object.assign({}, state, {
        on_edit: true,
        errors: [],
        loaded_contact: action.contact
      });
    case CANCEL_EDITION:
      return Object.assign({}, state, {
        on_edit: false,
        errors: [],
        loaded_contact: ContactFactory.empty()
      });
    case REMOVE:
      add_contact_to_deleted_list(action.contact);

      const index = state.rows.indexOf(action.contact);
      return Object.assign({}, state, {
        on_edit: (action.contact.id === state.loaded_contact.id ? false : state.on_edit),
        errors: [],
        loaded_contact: (action.contact.id === state.loaded_contact.id ? ContactFactory.empty() : state.loaded_contact),
        rows: [
          ...state.rows.slice(0, index), 
          ...state.rows.slice(index+1)
        ]
      });
    default:
      return state;
  }
};

export default contacts
