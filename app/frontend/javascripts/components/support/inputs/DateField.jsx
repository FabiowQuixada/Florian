import React from 'react';
import I18n from './../../../i18n';
import { EDIT_FIELD } from './../../../constants/generalConstants';
import PropTypes from 'prop-types';

const DatePicker = require("react-bootstrap-date-picker");

const DateField = ({
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
      <DatePicker type="text"
        name={attr}
        id={id}
        onChange={ (value, formatted_value) => {
          store.dispatch({
            type: EDIT_FIELD,
            field: $(`#${id}`).attr('name'),
            value: value
          })}
        }
        value={value}
        dateFormat={I18n.t("date.formats.javascript_format.date").toUpperCase()}
        dayLabels={Object.values(I18n.t('date.abbr_day_names'))}
        monthLabels={Object.values(I18n.t('date.month_names')).slice(1, 13)}
        showClearButton={false}
        disabled={disabled}
        className={"form-control" + (tempField ? ' temp_field' : '')} />
      <span className="input-group-addon"><i className="glyphicon glyphicon-th"></i></span>
    </div>
  </div>
)

DateField.contextTypes = {
  store: React.PropTypes.object
};

DateField.propTypes = {
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

export default DateField
