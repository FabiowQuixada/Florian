import { on_page, currency_sum } from "./../support/application";
import { format_competence } from "./../support/dates";

$(() => { if(on_page("bills", "form")) new BillsForm(); });

const BillsForm = (function() {
  function BillsForm() {

    this.before_submit_or_leave = () => format_competence("bill_aux_competence", "bill_competence");

    $("#main_form").on("submit", () => this.before_submit_or_leave);
    $("#bill_aux_competence").on("change", () => this.before_submit_or_leave);
    $("#summable-inputs input").on("change", () => $("#bill_totals").val(currency_sum("#summable-inputs input")));
  }

  return BillsForm;
}());

export default BillsForm;
