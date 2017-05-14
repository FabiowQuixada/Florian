import React from 'react';
import PropTypes from 'prop-types';

const HiddenField = ({ 
	    model,
        attr,
        value,
        className,
        id = `${model}_${attr}`,
        name = `${model}[${attr}]`
      }) => (
  <input type="hidden"
    name={name}
    id={id}
    className={className}
    value={value || ''} />
)

HiddenField.propTypes = {
  model: PropTypes.string,
  attr: PropTypes.string,
  value: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number
  ]),
  id: PropTypes.string,
  name: PropTypes.string,
  className: PropTypes.string
}

export default HiddenField
