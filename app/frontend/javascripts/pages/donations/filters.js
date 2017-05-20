import { on_page } from "./../support/application";
import { display_error } from "./../support/message_area";
import { validate_period, to_rails_date } from "./../support/dates";

$(() => { if(on_page("donations", "index")) new DonationFilters(); });

const DonationFilters = (function() {
  function DonationFilters() {
    const that = this;

    this.setup_listeners = () => {

      $("body").on("submit", "#search_form", e => {
        try {
          if(!that.validate(that.build_filter_obj())) {
            e.preventDefault();
          }
        } catch(error) {
          e.preventDefault();
          display_error(error);
        }
      });
    };

    this.validate = ({ start_date, end_date }) => {
      const errors = validate_period(start_date, end_date);

      if(errors.length !== 0) {
        display_error(errors, "filter");
        return false;
      }

      return true;
    };

    this.build_filter_obj = () => ({
      start_date: to_rails_date($("#q_donation_date_gteq").val()),
      end_date: to_rails_date($("#q_donation_date_lteq").val())
    });

    this.setup_listeners();
  }

  return DonationFilters;
}());

export default DonationFilters;
