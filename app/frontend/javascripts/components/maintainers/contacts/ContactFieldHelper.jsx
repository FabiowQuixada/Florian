import React from 'react';
import HiddenField from './../../support/inputs/HiddenField'
import PropTypes from 'prop-types';

const ContactFieldHelper = ({ contact, attr }) => {
  if(attr === 'id' && contact[attr] < 0) {
    return null;
  }

  return (
  	<HiddenField 
      name={`maintainer[contacts_attributes][${contact.id}][${attr}]`}
      id={`maintainer_contacts_attributes_${contact.id}_${attr}`}
      className={`contact_${attr}`}
      value={contact[attr]} />
  );
}

ContactFieldHelper.propTypes = {
  contact: PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
    position: PropTypes.string,
    email_address: PropTypes.string,
    telephone: PropTypes.string,
    celphone: PropTypes.string,
    fax: PropTypes.string
  }),
  attr: PropTypes.string.isRequired
}

export default ContactFieldHelper
