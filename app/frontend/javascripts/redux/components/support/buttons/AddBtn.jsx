import React from 'react';
import I18n from './../../../../i18n'
import PropTypes from 'prop-types';

const AddBtn = ({ onClick, obj, display = true }) => (
  <button 
      type="button" 
      onClick={ () => onClick(obj) } 
      className={`btn btn-primary btn-xs add-btn ${(display ? '' : 'hidden')}`}>
    {I18n.t('helpers.action.add')}
  </button>
)

AddBtn.propTypes = {
  onClick: PropTypes.func.isRequired,
  obj: PropTypes.object.isRequired,
  display: PropTypes.bool
}

export default AddBtn
