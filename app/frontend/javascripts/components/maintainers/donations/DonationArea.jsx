import React from 'react';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';
import I18n from './../../../i18n'
import DonationForm from './DonationForm'
import Donations from './Donations'
import { LOAD_LIST_FROM_SERVER } from './../../../constants/donationsConstants';
import { add, remove } from './../../../actions/donationsActionCreators';
import { cleanErrors } from './../../../actions/generalActionCreators';

const DonationArea = ({ donations }, { store }) => {
  // TODO: This is a quick-fix due to an issue
  // with the communication between React and
  // Rails. Yeah, I know, this is *really* ugly;
  if(donation_first_time) {
    store.dispatch({
      type: LOAD_LIST_FROM_SERVER,
      rows: donationList
    });
    donation_first_time = false;
  }

  return (
    <div>
      <DonationForm 
        donation={ donations.loaded_donation }
        onAddDonation={ donation => store.dispatch(add(donation)) }
        errors={ donations.errors }
        onErrorsClose={ () => store.dispatch(cleanErrors()) } />

      <Donations 
        data={ donations.rows }
        onDonationDestroy={ donation => store.dispatch(remove(donation)) } />

      <input 
        type="hidden" 
        id="maintainer_donations_to_be_deleted" 
        name="maintainer[donations_to_be_deleted]" />
    </div>
  );
}

DonationArea.contextTypes = {
  store: React.PropTypes.object
};

const mapStateToProps = state => ({ donations: state.donations });

export default connect(mapStateToProps, null)(DonationArea);
