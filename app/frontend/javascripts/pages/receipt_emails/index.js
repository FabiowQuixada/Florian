import { on_page } from "./../support/application";
import { clean_resend_modal, clean_send_test_modal } from "./modals";

$(() => { if(on_page("receipt_emails", "index")) new ReceiptEmailsIndex(); });

const ReceiptEmailsIndex = (function() {
  function ReceiptEmailsIndex() {
    this.setup_listeners = () => {
      $("body").on("click", ".resend_btn", e => {
        const elem = $(e.currentTarget);
        clean_resend_modal();

        const id = elem.closest(".model_row").find(".model_id").text();
        $("#receipt_email_id").val(id);
        $(".modal_maintainer_name").text(elem.closest(".model_row").find(".receipt_maintainer").text());
        $("#resend_email_modal").modal("show");
      });

      $("body").on("click", ".send_test_btn", e => {
        const elem = $(e.currentTarget);
        clean_send_test_modal();

        const id = elem.closest(".model_row").find(".model_id").text();
        $("#receipt_email_id").val(id);
        $(".modal_maintainer_name").text(elem.closest(".model_row").find(".receipt_maintainer").text());
        $("#send_test_email_modal").modal("show");
      });

      $("body").on("click", "#recent_emails_btn", () => {
        $("#recent_emails_modal").modal("show");
      });
    };

    this.setup_listeners();
  }

  return ReceiptEmailsIndex;
}());

export default ReceiptEmailsIndex;
