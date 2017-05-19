let donation_temp_id = -1;

class DonationFactory {
  static new(
           id = donation_temp_id--,
           donation_date = '2017-09-09',
           value = '',
           remark = 'cirurgical masks'
         ) {
    return {
      id,
      donation_date,
      value,
      remark
    };
  }

  static empty(id = donation_temp_id--) {
    return {
      id,
      donation_date: '',
      value: '0.00',
      remark: ''
    };
  }

  static dateless(id = donation_temp_id--) {
    return {
      id,
      donation_date: '',
      value: '0.00',
      remark: 'skin cream'
    };
  }
}

export default DonationFactory;
