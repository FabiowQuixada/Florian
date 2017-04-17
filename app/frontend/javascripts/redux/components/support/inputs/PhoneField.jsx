import React from 'react';
import I18n from './../../../../i18n';
import { EDIT_FIELD } from './../../../constants/generalConstants';
import PropTypes from 'prop-types';
import MaskedInput from 'react-maskedinput';

const PhoneField = ({
        label,
        model,
        attr,
        value,
        id = `${model}_${attr}`,
        name = `${model}[${attr}]`,
        bs_col = "col-md-4",
        tempField,
        disabled
      }, { store }) => (
  <div className={`form-group ${bs_col}`}>
    <label htmlFor={id}>{I18n.t(`activerecord.attributes.${model}.${attr}`)}</label>
    <MaskedInput mask="(11) 1111-1111" placeholder="(__) ____-____"
      name={attr}
      id={id}
      onChange={field => {
        store.dispatch({
          type: EDIT_FIELD,
          field: field.target.name,
          value: field.target.value
        })}
      }
      value={value}
      className={"form-control " + (tempField ? ' temp_field' : '')} />
  </div>
)

PhoneField.contextTypes = {
  store: React.PropTypes.object
};

PhoneField.propTypes = {
  label: PropTypes.string,
  model: PropTypes.string.isRequired,
  attr: PropTypes.string.isRequired,
  value: PropTypes.string,
  id: PropTypes.string,
  name: PropTypes.string,
  bs_col: PropTypes.string,
  tempField: PropTypes.bool,
  disabled: PropTypes.bool
}

export default PhoneField
