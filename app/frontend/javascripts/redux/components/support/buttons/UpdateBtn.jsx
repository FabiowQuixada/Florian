import React from 'react';
import I18n from './../../../../i18n'
import PropTypes from 'prop-types';

const UpdateBtn = ({ onClick, obj, display }) => (
  <button 
      type="button" 
      onClick={ () => onClick(obj) } 
      className={`btn btn-primary btn-xs update-btn ${(display ? '' : 'hidden')}`}>
    {I18n.t('helpers.action.update')}
  </button>
)

UpdateBtn.propTypes = {
  onClick: PropTypes.func.isRequired,
  obj: PropTypes.object.isRequired,
  display: PropTypes.bool
}

export default UpdateBtn
