import React from 'react';
import I18n from './../../../../i18n'
import PropTypes from 'prop-types';

const CancelBtn = ({ onClick, obj, display }) => (
  <button 
      type="button" 
      onClick={ () => onClick(obj) } 
      className={`btn btn-primary btn-xs cancel-btn ${(display ? '' : 'hidden')}`}>
    {I18n.t('helpers.action.cancel')}
  </button>
)

CancelBtn.propTypes = {
  onClick: PropTypes.func.isRequired,
  obj: PropTypes.object,
  display: PropTypes.bool
}

export default CancelBtn
