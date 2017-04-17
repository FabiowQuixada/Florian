import React from 'react';
import I18n from './../../../../i18n';
import { EDIT_FIELD } from './../../../constants/generalConstants';
import PropTypes from 'prop-types';

const TextField = ({
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
    <input type="text"
      name={name}
      id={id}
      onChange={field => {
        store.dispatch({
          type: EDIT_FIELD,
          field: attr,
          value: field.target.value
        })}
      }
      value={value}
      className={"form-control" + (tempField ? ' temp_field' : '')} />
  </div>
)

TextField.contextTypes = {
  store: React.PropTypes.object
};

TextField.propTypes = {
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

export default TextField
