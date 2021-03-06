import { toogle_admin_data } from "./application";
import { display_confirm_modal } from "./../support/modals";
import I18n from "./../../i18n";
import Constants from "./../../server_constants";

const display_about_modal = () => $("#app_about_modal").modal("show");
const display_author_email_modal = () => display_confirm_modal(I18n.t("app_data.author"), Constants.admin_email);

$(() => {
  $(".admin_key_btn").on("click", toogle_admin_data);
  $("#app_about_btn").on("click", display_about_modal);
  $("#author_email_btn").on("click", display_author_email_modal);
  $(".numbers_only").on("blur", (index, field) => {
    if(!$(field).val())
      $(field).val("0");
  });
});
