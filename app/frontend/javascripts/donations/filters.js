import { on_page } from './../application'
import { display_error } from './../message_area'
import { validate_period, to_rails_date } from './../dates'

$(() => { if(on_page('donations', 'index')) donations_filters() });

const donations_filters = () => {
  $('#search_form').on('submit', e => {
    try { 
      const start_date = to_rails_date($('#q_donation_date_gteq').val());
      const end_date = to_rails_date($('#q_donation_date_lteq').val());
      const errors = validate_period(start_date, end_date);

      if(errors.length !== 0) {
        display_error(errors, 'filter');
        e.preventDefault();
      }
    } catch(error) {
      e.preventDefault();
      display_error(error);
    }
  });
}