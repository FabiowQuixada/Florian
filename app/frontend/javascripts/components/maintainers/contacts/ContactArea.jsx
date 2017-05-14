import React from 'react';
import ContactForm from './ContactForm'
import Contacts from './Contacts'
import { LOAD_LIST_FROM_SERVER } from './../../../constants/contactsConstants';
import { add, load, update, cancel_edition, remove } from './../../../actions/contactsActionCreators';
import { cleanErrors } from './../../../actions/generalActionCreators';
import { connect } from 'react-redux';

const ContactArea = ({ contacts }, { store }) => {
  // TODO: This is a quick-fix due to an issue
  // with the communication between React and
  // Rails. Yeah, I know, this is *really* ugly;
  if(contact_first_time) {
    store.dispatch({
      type: LOAD_LIST_FROM_SERVER,
      rows: contactList
    });
    contact_first_time = false;
  }

  return (
    <div id="contact_area">
      <ContactForm 
        contact={ contacts.loaded_contact }
        onAddContact={ contact => store.dispatch(add(contact)) }
        onUpdateContact={ contact => store.dispatch(update(contact)) }
        onCancelContactEdition={ () => store.dispatch(cancel_edition()) }
        errors={ contacts.errors }
        onErrorsClose={ () => store.dispatch(cleanErrors()) }
        onEdit={ contacts.on_edit } />

      <Contacts 
        data={ contacts.rows }
        onContactEdit={ contact => store.dispatch(load(contact)) }
        onContactDestroy={ contact => store.dispatch(remove(contact)) } />

      <input 
        type="hidden" 
        id="maintainer_contacts_to_be_deleted" 
        name="maintainer[contacts_to_be_deleted]" />
    </div>
  );
}

ContactArea.contextTypes = {
  store: React.PropTypes.object
};

const mapStateToProps = state => ({ contacts: state.contacts });

export default connect(mapStateToProps, null)(ContactArea);
