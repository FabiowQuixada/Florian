import I18n from './../../i18n'
import { ADD, REMOVE, LOAD_LIST_FROM_SERVER } from './../constants/donationsConstants';
import { EDIT_FIELD, CLEAN_ERRORS } from './../constants/generalConstants';
import { to_money } from './../../application';
import DonationFactory from './../../factories/DonationFactory.js'

if(!global._babelPolyfill) {
  require('babel-polyfill');
}

let donationList;
const errors = new Array();

const initial_state = {
  errors: [],
  loaded_donation: DonationFactory.empty(),
  rows: []
};

const validate = donation => {
  errors.length = 0;

  if(!donation.donation_date) {
    const attribute = I18n.t("activerecord.attributes.donation.date");
    errors.push(I18n.t("errors.messages.blank", { attribute }));
  }

  if((!donation.value || donation.value === to_money(0)) && !donation.remark) {
    errors.push(I18n.t('errors.donation.value_or_remark'));
  }

  return errors.length === 0;
}

const add_donation_to_deleted_list = donation => {
  if(donation.id > 0) {
    $('#maintainer_donations_to_be_deleted').val(
      `${$('#maintainer_donations_to_be_deleted').val()}${donation.id},`
    );
  }
}

const donations = (state = initial_state, action) => {
  switch (action.type) {
    case CLEAN_ERRORS:
      return Object.assign({}, state, {
        errors: []
      });
    case EDIT_FIELD:
      return Object.assign({}, state, {
        loaded_donation: Object.assign({}, state.loaded_donation, {
          [action.field]: action.value
        })
      });
    case LOAD_LIST_FROM_SERVER:
      return Object.assign({}, state, {
        rows: action.rows
      });
    case ADD:
      if(validate(action.donation)) {
        return Object.assign({}, state, {
          errors: [],
          loaded_donation: DonationFactory.empty(),
          rows: [
            ...state.rows,
            action.donation
          ]
        });
      } else {
        return Object.assign({}, state, {
          errors: errors
        });
      }
    case REMOVE:
      add_donation_to_deleted_list(action.donation);

      const index = state.rows.indexOf(action.donation);
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

export default donations
