import React from 'react';
import HiddenField from './../../support/inputs/HiddenField'
import PropTypes from 'prop-types';

const DonationFieldHelper = ({ donation, attr }) => {
  if(attr === 'id' && donation[attr] < 0) {
    return <HiddenField 
      className={`donation_${attr}`}
      value={donation[attr]} />;
  }

  return (
	  <HiddenField 
      name={`maintainer[donations_attributes][${donation.id}][${attr}]`}
      id={`maintainer_donations_attributes_${donation.id}_${attr}`}
      className={`donation_${attr}`}
      value={donation[attr]} />
  );
}

DonationFieldHelper.propTypes = {
  donation: PropTypes.shape({
    id: PropTypes.number,
    donation_date: PropTypes.string.isRequired,
    value: PropTypes.string,
    remark: PropTypes.string
  }),
  attr: PropTypes.string.isRequired,
}

export default DonationFieldHelper
