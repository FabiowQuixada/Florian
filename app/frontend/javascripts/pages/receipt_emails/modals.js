import { on_controller } from "./../support/application";
import { display_error, display_info, display_notice } from "./../support/message_area";
import I18n from "./../../i18n";
import ServerFunctions from "./../../server_functions";

$(() => { if(on_controller("receipt_emails")) new ReceiptEmailsModals(); });

export const clean_resend_modal = () => $("#resend_competence").val(default_competence());
export const clean_send_test_modal = () => $("#send_test_competence").val(default_competence());
const default_competence = () => `${("0" + (new Date().getMonth()+1)).slice(-2)}/${new Date().getFullYear()}`;

const ReceiptEmailsModals = (function() {
  function ReceiptEmailsModals() {
    this.setup_listeners = () => {
      const self = this;

      $("body").on("click", "#modal_save_btn",
        () => { document.getElementById("main_form").submit(); }
      );

      $("body").on("click", "#resend_email_modal .btn-ok",
        () => {
          display_info(I18n.t("alert.email.resending"));
          $("#resend_email_modal").modal("hide");

          const id = $("#receipt_email_id").val();
          $.ajax(self.send_request(
            ServerFunctions.paths.resend_receipt_email(id),
            self.build_email(),
            $("#resend_competence").val()
          ));
        }
      );

      $("body").on("click", "#send_test_email_modal .btn-ok",
        () => {
          display_info(I18n.t("alert.email.sending_test"));
          $("#send_test_email_modal").modal("hide");

          const id = $("#receipt_email_id").val();
          $.ajax(self.send_request(
            ServerFunctions.paths.send_test_receipt_email(id),
            self.build_email(),
            $("#send_test_competence").val()
          ));
        }
      );
    };

    this.add_history_item = email => {
      $("#history_table > tbody:last-child").append(
        `<tr>
          <td>${email.date}<\/td>
          <td>${email.value}<\/td>
          <td>${email.type}<\/td>
          <td>${email.user}<\/td>
        <\/tr>`
      );
    };

    this.add_recent_email = email => {
      $("#recent_emails_table > tbody:last-child").append(
        `<tr>
          <td>${email.date}<\/td>
          <td>${email.maintainer}<\/td>
          <td>${email.type}<\/td>
        <\/tr>`
      );
    };

    this.send_request = (url, receipt_email, competence) => ({
      url,
      type: "POST",
      beforeSend: xhr => {
        xhr.setRequestHeader("X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content"));
      },
      data: {
        competence,
        receipt_email
      },
      success: response => {
        display_notice(response.message);
        this.add_history_item(response.model);
      },
      error: response => {
        display_error(response.responseText);
      }
    });

    this.build_email = () => ({
      id: $("#receipt_email_id").val(),
      recipients_array: $("#receipt_email_recipients_array").val(),
      value: $("#receipt_email_value").val(),
      maintainer: $("#receipt_email_maintainer").val(),
      title: $("#receipt_email_title").val(),
      body: $("#receipt_email_body").val(),
      active: $("#model_status").val()
    });

    this.setup_listeners();
  }

  return ReceiptEmailsModals;
}());

export default ReceiptEmailsModals;
