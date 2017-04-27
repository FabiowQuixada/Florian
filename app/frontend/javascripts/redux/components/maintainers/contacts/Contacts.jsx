import React from 'react';
import I18n from './../../../../i18n'
import Contact from './Contact'
import PropTypes from 'prop-types';

const Contacts = ({ data, onContactEdit, onContactDestroy }) => {
  let table_rows = new Array();

  for (let i = 0; i < data.length; i++) {
    table_rows.push(
      <Contact 
        contact={ data[i] } 
        key={ i }
        onEdit={ onContactEdit }
        onDestroy={ onContactDestroy } />
    );
  }
  
  return (
    <div id="contacts_table">
      <table className="table table-striped table-condensed table-bordered unbreakable-table">
        <thead>
          <tr>
            <th>{I18n.t("activerecord.attributes.contact.name")}</th>
            <th>{I18n.t("activerecord.attributes.contact.position")}</th>
            <th>{I18n.t("activerecord.attributes.contact.telephone")}</th>
            <th>{I18n.t("activerecord.attributes.contact.celphone")}</th>
            <th className="icon-column-2"></th>
            <th className="icon-column-2"></th>
          </tr>
        </thead>
        <tbody>
          <tr id="no_contacts_row" className={table_rows.length === 0 ? '' : 'hidden'}>
            <td colSpan="6">
              {I18n.t("model_phrases.none_registered.n.p", {model: "contacts"})}
            </td>
          </tr>
          {table_rows}
        </tbody>
      </table>
    </div>
  );
}

Contacts.propTypes = {
  data: PropTypes.arrayOf(PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
    position: PropTypes.string,
    email_address: PropTypes.string,
    telephone: PropTypes.string,
    celphone: PropTypes.string,
    fax: PropTypes.string
  })).isRequired,
  onContactEdit: PropTypes.func.isRequired,
  onContactDestroy: PropTypes.func.isRequired
};

export default Contacts
