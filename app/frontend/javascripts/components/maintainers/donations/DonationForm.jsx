import React from 'react';
import I18n from './../../../i18n'
import ErrorAlert from './../../support/ErrorAlert'
import DateField from './../../support/inputs/DateField'
import MoneyField from './../../support/inputs/MoneyField'
import TextField from './../../support/inputs/TextField'
import AddBtn from './../../support/buttons/AddBtn'
import PropTypes from 'prop-types';

const DonationForm = ({ donation, onAddDonation, errors, onErrorsClose }) => (
  <div className="row">
    <div className="container-fluid">
      <div className="panel panel-default">
        <div id="donation_panel_header" className="panel-heading">
          {I18n.t('helpers.maintainer.new_donation')}
        </div>
        <div className="panel-body">
          <div id="donation_data">
            <ErrorAlert 
              msg_box_id="donation" 
              errors={ errors }
              onClose={ onErrorsClose } />

            <div className="row">
              <DateField model="donation" attr="donation_date" value={donation.donation_date} tempField />
              <MoneyField model="donation" attr="value" value={donation.value} tempField />
              <TextField model="donation" attr="remark" value={donation.remark} tempField />
            </div>

            <div className="row">
              <div className="col-md-12 right">
                <AddBtn onClick={ onAddDonation }
                  obj={donation} />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
)

DonationForm.propTypes = {
  donation: PropTypes.shape({
    id: PropTypes.number,
    donation_date: PropTypes.string.isRequired,
    value: PropTypes.string,
    remark: PropTypes.string
  }),
  onAddDonation: PropTypes.func.isRequired,
  errors: PropTypes.arrayOf(PropTypes.string),
  onErrorsClose: PropTypes.func.isRequired
}

export default DonationForm
