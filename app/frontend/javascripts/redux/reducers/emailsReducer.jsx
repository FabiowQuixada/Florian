import I18n from './../../i18n'
import { ADD, REMOVE, LOAD_LIST_FROM_SERVER } from './../constants/emailsConstants';
import { EDIT_FIELD } from './../constants/generalConstants';
import { validate_email } from './../../application'
import { hide_errors, display_error } from './../../message_area'

let emailList;
const errors = new Array();

const initial_state = {
  errors: [],
  email_field: '',
  rows: []
};

const validate = (state, email_address) => {
  errors.length = 0;

  if(!email_address) {
    errors.push(I18n.t('alert.email.fill_a_recipient'));
  }

  if(email_address && !validate_email(email_address)) {
    const attribute = I18n.t('activerecord.attributes.contact.email_address');
    errors.push(I18n.t('errors.messages.invalid', { attribute: attribute }));
  }

  if(state.rows.includes(email_address)) {
    errors.push(I18n.t('alert.email.duplicated_recipient'));
  }

  return errors.length === 0;
}

const emails = (state = initial_state, action) => {
  switch (action.type) {
    case LOAD_LIST_FROM_SERVER:
      return Object.assign({}, state, {
        rows: action.rows
      });
    case EDIT_FIELD:
      return Object.assign({}, state, {
        email_field: action.value
      });
    case ADD:
      if(validate(state, action.email.address)) {
        hide_errors();
        return Object.assign({}, state, {
          errors: [],
          email_field: '',
          rows: [
            ...state.rows,
            action.email
          ]
        });
      } else {
        display_error(errors);
        return state;
      }
    case REMOVE:
      const index = state.rows.indexOf(action.email);
      return Object.assign({}, state, {
        errors: [],
        rows: [
          ...state.rows.slice(0, index), 
          ...state.rows.slice(index+1)
        ]
      });
    default:
      return state;
  }
};

export default emails
