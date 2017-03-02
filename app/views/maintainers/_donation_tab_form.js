/** 
  This file is a workaround because I din't get Karma to precompile erb files.
  Here are the non-erb-dependent functions;
**/


// Temporary donations have negative id;
let temp_donation_id = -1;
let transient_donations = 0;

const new_donations = () => transient_donations > 0

const build_donation = () => {
  const id = $('#new_donation_id').val();
  const donation_date = $('#new_donation_date').val();
  const value = $('#new_donation_value').val();
  const remark = $('#new_donation_remark').val();

  return {
    id: temp_donation_id,
    donation_date,
    value,
    remark
  }
}

const clean_donation_fields = () => {
  $('#new_donation_date').val('');
  $('#new_donation_value').val(to_money(0));
  $('#new_donation_remark').val('');

  hide_errors_from_box('donation');
}