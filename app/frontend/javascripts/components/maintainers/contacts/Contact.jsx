import React from 'react';
import EditBtn from './../../support/buttons/table/TableEditBtn'
import DestroyBtn from './../../support/buttons/table/TableDestroyBtn'
import ContactFieldHelper from './ContactFieldHelper'
import PropTypes from 'prop-types';

const Contact = ({ contact, onEdit, onDestroy }) => (
  <tr id={`contact_${contact.id}`}>
    <td className="contact_id hidden">{contact.id}</td>
    <td className="contact_name">{contact.name}</td>
    <td className="contact_position">{contact.position}</td>
    <td>{contact.telephone}</td>
    <td>{contact.celphone}</td>
    <td className="icon-column-2"><EditBtn onClick={ () => onEdit(contact) } /></td>
    <td className="icon-column-2"><DestroyBtn onClick={ () => onDestroy(contact) } /></td>

    {/* Server communication data */}
    <td className="server-communication-data hidden">
      <ContactFieldHelper contact={contact} attr="id" />
      <ContactFieldHelper contact={contact} attr="name" />
      <ContactFieldHelper contact={contact} attr="position" />
      <ContactFieldHelper contact={contact} attr="email_address" />
      <ContactFieldHelper contact={contact} attr="telephone" />
      <ContactFieldHelper contact={contact} attr="celphone" />
      <ContactFieldHelper contact={contact} attr="fax" />
    </td>
  </tr>
)

Contact.propTypes = {
  contact: PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
    position: PropTypes.string,
    email_address: PropTypes.string,
    telephone: PropTypes.string,
    celphone: PropTypes.string,
    fax: PropTypes.string
  }),
  onEdit: PropTypes.func.isRequired,
  onDestroy: PropTypes.func.isRequired
}

export default Contact
