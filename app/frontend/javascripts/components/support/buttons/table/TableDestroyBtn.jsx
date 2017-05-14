import React from 'react';
import I18n from './../../../../i18n'
import Constants from './../../../../server_constants'
import PropTypes from 'prop-types';

const DestroyBtn = ({ onClick }) => (
  <img src={Constants.paths.assets.delete}
    onClick={onClick}
    className="remove_btn"
    title={I18n.t('helpers.action.remove')}
    alt={I18n.t('helpers.action.remove')} />
)

DestroyBtn.propTypes = {
  onClick: PropTypes.func.isRequired
}

export default DestroyBtn
