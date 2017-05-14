import { on_page } from "./../support/application";
import Constants from "./../../server_constants";

$(() => { if(on_page("donations", "form")) new DonationsForm(); });

const DonationsForm = (function() {
  function DonationsForm() {
    $("#create_and_new_btn").on("click", () => {
      $("form").get(0).setAttribute("action", Constants.paths.create_and_new_donations);
      $("#main_form").submit();
    });
  }

  return DonationsForm;
}());

export default DonationsForm;
