import MaintainersDonationTabForm from "./../../../../app/frontend/javascripts/pages/maintainers/donation_tab_form";
import Constants from "./../../../../app/frontend/javascripts/server_constants";

describe("Maintainer donation tab form", () => {
  let donation_tab_form;

  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = "base/spec/javascripts/fixtures";
    loadFixtures("maintainers/donation_tab_form.html");
    donation_tab_form = new MaintainersDonationTabForm();
    $.holdReady(true);
  });

  describe("cant_set_parcels", () => {
    it("blocks parcel field if 'other' payment frequency option is selected", () => {
      $("#maintainer_payment_frequency").val(Constants.payment_freq.other);
      expect(donation_tab_form.cant_set_parcels()).toBe(true);
    });

    it("blocks parcel field if 'undefined' payment frequency option is selected", () => {
      $("#maintainer_payment_frequency").val(Constants.payment_freq.undefined);
      expect(donation_tab_form.cant_set_parcels()).toBe(true);
    });

    it("blocks parcel field if no payment frequency option is selected", () => {
      $("#maintainer_payment_frequency").val("");
      expect(donation_tab_form.cant_set_parcels()).toBe(true);
    });

    it("unblocks parcel field if a valid payment frequency option is selected", () => {
      $("#maintainer_payment_frequency").val(Constants.payment_freq.monthly);
      expect(donation_tab_form.cant_set_parcels()).toBe(false);
    });
  });

  describe("toogle_parcel_qty_field", () => {
    it("allows user to edit 'payment period' if 'parcel frequency' is set to 'semiannually'", () => {
      $("#maintainer_payment_period").attr("readonly");
      $("#maintainer_payment_frequency").val(Constants.payment_freq.semiannually);
      donation_tab_form.toogle_parcel_qty_field();
      expect($("#maintainer_payment_period").is("[readonly]")).toBe(false);
    });

    it("prevents user from editing 'payment period' if 'parcel frequency' is not set", () => {
      $("#maintainer_payment_period").removeAttr("readonly");
      $("#maintainer_payment_frequency").val(Constants.payment_freq.undefined);
      donation_tab_form.toogle_parcel_qty_field();
      expect($("#maintainer_payment_period").is("[readonly]")).toBe(true);
    });
  });

  describe("set_last_parcel_date", () => {
    beforeEach(() => {
      $("#maintainer_last_parcel").val("undefined");
    });

    it("cleans 'last parcel date' if 'first parcel' field is empty", () => {
      $("#maintainer_first_parcel").val("");
      donation_tab_form.set_last_parcel_date();
      expect($("#maintainer_last_parcel").val()).toEqual("");
    });

    it("cleans 'last parcel date' if 'first parcel' field is empty", () => {
      $("#maintainer_payment_frequency").val("");
      donation_tab_form.set_last_parcel_date();
      expect($("#maintainer_last_parcel").val()).toEqual("");
    });

    it("cleans 'last parcel date' if 'first parcel' field is empty", () => {
      $("#maintainer_payment_period").val("");
      donation_tab_form.set_last_parcel_date();
      expect($("#maintainer_last_parcel").val()).toEqual("");
    });

    /**
     *
     * TODO Locale is not loaded with Karma (date format);
     *
    **/

    // it("sets 'last parcel date' field when all appropriate fields are filled (freq: annually)", () => {
    //   $('#maintainer_first_parcel').val('04/28/2017');
    //   $('#maintainer_payment_frequency').val(Constants.payment_freq.annually);
    //   $('#maintainer_payment_period').val('2');
    //   donation_tab_form.set_last_parcel_date();
    //   expect($('#maintainer_last_parcel').val()).toEqual('04/28/2019');
    // });

    // it("sets 'last parcel date' field when all appropriate fields are filled (freq: monthly)", () => {
    //   $('#maintainer_first_parcel').val('03/28/2017');
    //   $('#maintainer_payment_frequency').val(Constants.payment_freq.monthly);
    //   $('#maintainer_payment_period').val(3);
    //   donation_tab_form.set_last_parcel_date();
    //   expect($('#maintainer_last_parcel').val()).toEqual('06/28/2017');
    // });

    // it("sets 'last parcel date' field when all appropriate fields are filled (freq: semiannually)", () => {
    //   $('#maintainer_first_parcel').val('03/28/2017');
    //   $('#maintainer_payment_frequency').val(Constants.payment_freq.semiannually);
    //   $('#maintainer_payment_period').val(3);
    //   donation_tab_form.set_last_parcel_date();
    //   expect($('#maintainer_last_parcel').val()).toEqual('06/28/2017');
    // });

    // it("sets 'last parcel date' field when all appropriate fields are filled (freq: bimonthly)", () => {
    //   $('#maintainer_first_parcel').val('03/28/2017');
    //   $('#maintainer_payment_frequency').val(Constants.payment_freq.bimonthly);
    //   $('#maintainer_payment_period').val(3);
    //   donation_tab_form.set_last_parcel_date();
    //   expect($('#maintainer_last_parcel').val()).toEqual('06/28/2017');
    // });
  });

  describe("setup_listeners", () => {
    it("binds last parcel update to first parcel change", () => {
      spyOn(donation_tab_form, "set_last_parcel_date");
      $("#maintainer_first_parcel").trigger("change");
      expect(donation_tab_form.set_last_parcel_date).toHaveBeenCalled();
    });

    it("binds last parcel update to payment period change", () => {
      spyOn(donation_tab_form, "set_last_parcel_date");
      $("#maintainer_payment_period").trigger("change");
      expect(donation_tab_form.set_last_parcel_date).toHaveBeenCalled();
    });

    it("binds last parcel update to payment frequency change", () => {
      spyOn(donation_tab_form, "set_last_parcel_date");
      $("#maintainer_payment_frequency").trigger("change");
      expect(donation_tab_form.set_last_parcel_date).toHaveBeenCalled();
    });

    it("binds parel quantity update to payment frequency change", () => {
      spyOn(donation_tab_form, "toogle_parcel_qty_field");
      $("#maintainer_payment_frequency").trigger("change");
      expect(donation_tab_form.toogle_parcel_qty_field).toHaveBeenCalled();
    });
  });
});
