import BillsForm from "./../../../../app/frontend/javascripts/pages/bills/form";
import * as dates from "./../../../../app/frontend/javascripts/pages/support/dates";

describe("Bill form", () => {
  let bill_form;

  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = "base/spec/javascripts/fixtures";
    loadFixtures("bills/form.html");
    bill_form = new BillsForm();
    $.holdReady(true);
  });

  it("before_submit_or_leave", () => {
    spyOn(dates, "format_competence");
    $("#main_form").trigger("submit");
    expect(dates.format_competence).toHaveBeenCalled();
  });

  describe("setup_listeners", () => {
    it("formats competence on form submit", () => {
      spyOn(bill_form, "before_submit_or_leave");
      $("#main_form").trigger("submit");
      expect(bill_form.before_submit_or_leave).toHaveBeenCalled();
    });

    it("formats competence on form submit", () => {
      spyOn(dates, "format_competence");
      $("#bill_aux_competence").trigger("change");
      expect(dates.format_competence).toHaveBeenCalled();
    });

    // Karma does not load Locale;
    // it("updates totals input", () => {
    //   $('#input0').val(3);
    //   $('#input1').val(3);
    //   $('#input2').val(4);
    //   $("#summable-inputs input").first().trigger("change");
    //   expect($('#bill_totals').val()).toEqual(10);
    // });
  });
});
