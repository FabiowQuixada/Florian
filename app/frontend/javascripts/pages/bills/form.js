import { on_page, currency_sum } from "./../support/application";
import { format_competence } from "./../support/dates";
import { init } from "./../support/form_commons";

$(() => { if(on_page("bills", "form")) new BillsForm(); });

const BillsForm = (function() {
  function BillsForm() {
    const that = this;

    this.before_submit_or_leave = () => format_competence("bill_aux_competence", "bill_competence");

    this.setup_listeners = () => {
      $("body").on("submit", "#main_form", () => {
        that.before_submit_or_leave();
      });

      $("body").on("change", "#bill_aux_competence", () => {
        that.before_submit_or_leave();
      });

      $("body").on("change", "#summable-inputs input", () => {
        $("#bill_totals").val(currency_sum("#summable-inputs input"));
      });
    };

    init(this.before_submit_or_leave);
    this.setup_listeners();
  }

  return BillsForm;
}());

export default BillsForm;
