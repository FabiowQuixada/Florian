import React from 'react';
import I18n from './../../../../i18n'
import DestroyBtn from './../buttons/table/TableDestroyBtn'
import PropTypes from 'prop-types';

const Email = ({ field_name, email, onDestroy }) => (
  <tr className={`${field_name}_email_recipient`}>
    <td className="is_persisted hidden">{ email.is_persisted }</td>
    <td className="recipient_email middle">{ email.address }</td>
    <td className="button-wrapper"><DestroyBtn onClick={ () => onDestroy(email) } /></td>
  </tr>
)

Email.contextTypes = {
  store: React.PropTypes.object
};

Email.propTypes = {
  field_name: PropTypes.string.isRequired,
  email: PropTypes.shape({
    is_persisted: PropTypes.string,
    address: PropTypes.string
  }),
  onDestroy: PropTypes.func.isRequired
}

export default Email
