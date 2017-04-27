import React from 'react';
import I18n from './../../../../i18n'
import DestroyBtn from './../../support/buttons/table/TableDestroyBtn'
import DonationFieldHelper from './DonationFieldHelper'
import PropTypes from 'prop-types';

const Donation = ({ donation, onDestroy }) => (
  <tr id={`donation_${donation.id}_row`} className="donation_row">
    <td className="hidden-xs donation_id admin-only hidden">{ donation.id }</td>
    <td className="hidden-xs donation_date col-xs-6 col-md-3">{ I18n.l("date.formats.default", donation.donation_date) }</td>
    <td className="hidden-xs donation_value col-xs-6 col-md-3">{ donation.value }</td>
    <td className="hidden-xs donation_remark col-xs-12 col-md-6">{ donation.remark }</td>
    <td className="hidden-xs icon-column-2"><DestroyBtn onClick={ () => onDestroy(donation) } /></td>


    {/* Extra-small views (should not have the 'donation_id' class) */}
    <td colSpan="5" className="visible-xs">
      <table className="table table-striped table-bordered marginless">
        <tbody>
          <tr className="gray-background">
            <td className="admin-only hidden">{ donation.id }</td>
            <td className="donation_date">{ I18n.l("date.formats.default", donation.donation_date) }</td>
            <td className="donation_value">{ I18n.t('number.currency.format.unit') + ' ' + donation.value }</td>
            <td className="icon-column-2"><DestroyBtn onClick={ () => onDestroy(donation) } /></td>
          </tr><tr>
            <td colSpan="4" className="donation_remark white-background">{ donation.remark }</td>
          </tr>
        </tbody>
      </table>
    </td>

    {/* Server communication data */}
    <td className="server-communication-data hidden" colSpan="5">
      <DonationFieldHelper donation={donation} attr="id" />
      <DonationFieldHelper donation={donation} attr="donation_date" />
      <DonationFieldHelper donation={donation} attr="value" />
      <DonationFieldHelper donation={donation} attr="remark" />
    </td>
  </tr>
)

Donation.propTypes = {
  donation: PropTypes.shape({
    id: PropTypes.number,
    donation_date: PropTypes.string.isRequired,
    value: PropTypes.string,
    remark: PropTypes.string
  }),
  onDestroy: PropTypes.func.isRequired
}

export default Donation
