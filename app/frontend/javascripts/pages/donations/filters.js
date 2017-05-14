import { on_page } from "./../support/application";
import { display_error } from "./../support/message_area";
import { validate_period, to_rails_date } from "./../support/dates";

$(() => { if(on_page("donations", "index")) new DonationsFilters(); });

const DonationsFilters = (function() {
  function DonationsFilters() {
    $("#search_form").on("submit", e => {
      try {
        const start_date = to_rails_date($("#q_donation_date_gteq").val());
        const end_date = to_rails_date($("#q_donation_date_lteq").val());
        const errors = validate_period(start_date, end_date);

        if(errors.length !== 0) {
          display_error(errors, "filter");
          e.preventDefault();
        }
      } catch(error) {
        e.preventDefault();
        display_error(error);
      }
    });
  }

  return DonationsFilters;
}());

export default DonationsFilters;
