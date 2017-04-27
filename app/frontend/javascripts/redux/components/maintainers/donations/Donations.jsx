import React from 'react';
import I18n from './../../../../i18n'
import Donation from './Donation'
import PropTypes from 'prop-types';

const Donations = ({ data, onDonationDestroy }) => {
  let table_rows = new Array();

  for (let i = 0; i < data.length; i++) {
    table_rows.push(
      <Donation 
        donation={data[i]} 
        key={i}
        onDestroy={ onDonationDestroy } />
    );
  }

  return (
    <div id="donations_table">
      <table className="table table-striped table-condensed table-bordered unbreakable-table">
        <thead className="hidden-xs">
          <tr>
            <th className="admin-only id-column hidden"></th>
            <th>{I18n.t("activerecord.attributes.donation.date")}</th>
            <th>{I18n.t("activerecord.attributes.donation.value")}</th>
            <th className="hidden-xs column-lg">{I18n.t("activerecord.attributes.donation.remark")}</th>
            <th className="icon-column-2"></th>
          </tr>
        </thead>
        <tbody>
          <tr id="no_donations_row" className={table_rows.length === 0 ? '' : 'hidden'}>
            <td colSpan="4">
              {I18n.t("model_phrases.none_registered.n.p", {model: "donations"})}
            </td>
          </tr>
          {table_rows}
        </tbody>
      </table>
    </div>
  );
}

Donations.propTypes = {
  data: PropTypes.arrayOf(PropTypes.shape({
    id: PropTypes.number,
    donation_date: PropTypes.string.isRequired,
    value: PropTypes.string,
    remark: PropTypes.string
  })).isRequired,
  onDonationDestroy: PropTypes.func.isRequired
}

export default Donations
