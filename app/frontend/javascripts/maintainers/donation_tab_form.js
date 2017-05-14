import I18n from "./../i18n";
import { on_page } from "./../application";
import Constants from "./../server_constants";
import moment from "moment";

$(() => { if(on_page("maintainers", "form")) new MaintainersDonationTabForm(); });

const MaintainersDonationTabForm = (function() {
  function MaintainersDonationTabForm() {

    this.cant_set_parcels = () => {
      const frequency = $("#maintainer_payment_frequency").val();
      return !frequency || frequency === "" || frequency === Constants.payment_freq.undefined || frequency === Constants.payment_freq.other;
    };

    this.toogle_parcel_qty_field = () => {
      if(this.cant_set_parcels()) {
        $("#maintainer_payment_period").prop("readonly", true);
        $("#maintainer_payment_period").val("");
      } else {
        $("#maintainer_payment_period").prop("readonly", false);
      }
    };

    this.set_last_parcel_date = () => {

      const frequency = $("#maintainer_payment_frequency").val();
      const parcel_qty = $("#maintainer_payment_period").val();


      let { frequency_type, temp } = this. kkk(frequency, parcel_qty);

      this.update_last_parcel(parcel_qty, frequency_type, temp);
    };

    this.kkk = (frequency, parcel_qty) => {
      let frequency_type;
      let temp = parcel_qty;

      if(frequency === Constants.payment_freq.diary) {
        frequency_type = "days";
      } else if(frequency === Constants.payment_freq.weekly) {
        frequency_type = "weeks";
      } else if(frequency === Constants.payment_freq.monthly) {
        frequency_type = "months";
      } else if(frequency === Constants.payment_freq.bimonthly) {
        temp = 3;
        frequency_type = "months";
      } else if(frequency === Constants.payment_freq.semiannually) {
        temp = 6;
        frequency_type = "months";
      } else if(frequency === Constants.payment_freq.annually) {
        frequency_type = "years";
      }

      return { frequency_type, temp };
    };

    this.update_last_parcel = (parcel_qty, frequency_type, temp) => {
      const first_date = $("#maintainer_first_parcel").val();
      const last_date = $("#maintainer_last_parcel");

      last_date.val("");

      if(!first_date || this.cant_set_parcels() || !parcel_qty) {
        return;
      }

      if(parcel_qty !== 0 || (frequency_type !== undefined && frequency_type !== "")) {
        const date_format = I18n.t("date.formats.javascript_format.date").toUpperCase();
        last_date.val(moment(first_date, date_format).add((temp-1), frequency_type).format(date_format));
      }
    };

    this.setup_listeners = () => {
      $("#maintainer_first_parcel, #maintainer_payment_period, #maintainer_payment_frequency").on(
        "change", this.set_last_parcel_date);
      $("#maintainer_payment_frequency").change(this.toogle_parcel_qty_field);
    };

    this.toogle_parcel_qty_field();
    this.set_last_parcel_date();
    this.setup_listeners();
  }

  return MaintainersDonationTabForm;
}());

export default MaintainersDonationTabForm;
