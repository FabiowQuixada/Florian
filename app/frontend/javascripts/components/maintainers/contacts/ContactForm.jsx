import React from 'react';
import I18n from './../../../i18n'
import ErrorAlert from './../../support/ErrorAlert'
import HiddenField from './../../support/inputs/HiddenField'
import TextField from './../../support/inputs/TextField'
import EmailField from './../../support/inputs/EmailField'
import PhoneField from './../../support/inputs/PhoneField'
import AddBtn from './../../support/buttons/AddBtn'
import UpdateBtn from './../../support/buttons/UpdateBtn'
import CancelBtn from './../../support/buttons/CancelBtn'
import PropTypes from 'prop-types';

const ContactForm = ({ 
        contact, 
        onAddContact, 
        onUpdateContact, 
        onCancelContactEdition, 
        errors, 
        onErrorsClose,
        onEdit = false
      }) => (
  <div className="row">
    <div className="container-fluid">
      <div className="panel panel-default">
        <div id="contact_panel_header" className="panel-heading">
          {I18n.t('helpers.maintainer.new_contact')}
        </div>
        <div id="contact_data" className="panel-body">
          <ErrorAlert 
            msg_box_id="contact"
            errors={ errors }
            onClose={ onErrorsClose } />

          <HiddenField model="contact" attr="id" value={contact.id} tempField />

          <div className="row">
            <TextField model="contact" attr="name" value={contact.name} tempField />
            <TextField model="contact" attr="position" value={contact.position} />
            <EmailField model="contact" attr="email_address" value={contact.email_address} tempField />
          </div>
          <div className="row">
            <PhoneField model="contact" attr="telephone" value={contact.telephone} tempField />
            <PhoneField model="contact" attr="celphone" value={contact.celphone} tempField />
            <PhoneField model="contact" attr="fax" value={contact.fax} tempField />
          </div>

          <div className="row">
            <div className="col-md-12 right">
              <AddBtn onClick={ onAddContact }
                obj={ contact }
                display={ !onEdit } />
              <div className="btn-group btn-group-xs">
                <UpdateBtn 
                  onClick={ onUpdateContact }
                  obj={ contact }
                  display={ onEdit } />
                <CancelBtn 
                  onClick={ onCancelContactEdition }
                  display={ onEdit } />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
);

ContactForm.propTypes = {
  contact: PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
    position: PropTypes.string,
    email_address: PropTypes.string,
    telephone: PropTypes.string,
    celphone: PropTypes.string,
    fax: PropTypes.string
  }),
  onAddContact: PropTypes.func.isRequired,
  onUpdateContact: PropTypes.func.isRequired,
  onCancelContactEdition: PropTypes.func.isRequired,
  errors: PropTypes.arrayOf(PropTypes.string),
  onErrorsClose: PropTypes.func.isRequired,
  onEdit: PropTypes.bool
}

export default ContactForm
