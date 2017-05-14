import React from 'react';
import I18n from './../../../../i18n'
import Constants from './../../../..//server_constants'
import PropTypes from 'prop-types';

const EditBtn = ({ onClick }) => (
  <img src={Constants.paths.assets.edit}
    onClick={onClick}
    className="edit_btn"
    title={I18n.t('helpers.action.edit')}
    alt={I18n.t('helpers.action.edit')} />
)

EditBtn.propTypes = {
  onClick: PropTypes.func.isRequired
}

export default EditBtn
