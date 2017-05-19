import { on_page } from "./../support/application";
import { display_error } from "./../support/message_area";
import { format_competence, validate_period } from "./../support/dates";

$(() => { if(on_page("bills", "index")) new BillsFilters(); });

const BillsFilters = (function() {
  function BillsFilters() {
    this.setup_listeners = () => {
      const that = this;

      $("body").on("submit", "#search_form", e => {
        try {
          format_competence("aux_competence_lteq", "q_competence_lteq");
          format_competence("aux_competence_gteq", "q_competence_gteq");

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
      start_date: $("#q_competence_gteq").val(),
      end_date: $("#q_competence_lteq").val()
    });

    this.setup_listeners();
  }

  return BillsFilters;
}());

export default BillsFilters;
