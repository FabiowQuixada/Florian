import { on_page } from "./../support/application";

$(() => { if(on_page("bills", "index")) new BillsIndex(); });

const BillsIndex = (function() {
  function BillsIndex() {
    $("#graphs_btn").click( () => $("#graphs_modal").modal("show"));
  }

  return BillsIndex;
}());

export default BillsIndex;
