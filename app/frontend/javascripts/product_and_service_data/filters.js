import { on_page } from './../application';
import { display_error } from './../message_area';
import { validate_period, format_competence } from './../dates';

$(() => { if(on_page('product_and_service_data', 'index')) new ProductAndServiceDataFilters(); });

const ProductAndServiceDataFilters = (function() {
  function ProductAndServiceDataFilters() {
    $('#search_form').on('submit', e => {
      try {
        format_competence('aux_competence_lteq', 'q_competence_lteq');
        format_competence('aux_competence_gteq', 'q_competence_gteq');

        const start_date = $('#q_competence_gteq').val();
        const end_date = $('#q_competence_lteq').val();
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

  return ProductAndServiceDataFilters;
}());

export default ProductAndServiceDataFilters;
