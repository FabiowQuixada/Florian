import React from 'react';
import I18n from './../../../i18n';
import { EDIT_FIELD } from './../../../constants/generalConstants';
import CurrencyInput from 'react-currency-input';
import PropTypes from 'prop-types';

const MoneyField = ({
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
    <div className="input-group">
      <span className="input-group-addon">{I18n.t('number.currency.format.unit')}</span>
      <CurrencyInput type="text"
        name={attr}
        id={id}
        onChange={ value => {
          store.dispatch({
            type: EDIT_FIELD,
            field: attr,
            value: value
          })}
        }
        value={value}
        className={"form-control" + (tempField ? ' temp_field' : '')}
        decimalSeparator={I18n.t("number.currency.format.separator")}
        thousandSeparator={I18n.t("number.currency.format.delimiter")}
         />
    </div>
  </div>
)

MoneyField.contextTypes = {
  store: React.PropTypes.object
};

MoneyField.propTypes = {
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

export default MoneyField
