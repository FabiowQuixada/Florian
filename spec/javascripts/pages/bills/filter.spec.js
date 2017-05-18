import BillsFilters from "./../../../../app/frontend/javascripts/pages/bills/filters";
import BillFilterFactory from "./../../../../app/frontend/javascripts/factories/BillFilterFactory";
import * as dates from "./../../../../app/frontend/javascripts/pages/support/dates";

describe("Bill filters", () => {
  let bill_filters;

  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = "base/spec/javascripts/fixtures";
    loadFixtures("bills/filters.html");
    bill_filters = new BillsFilters();
    $.holdReady(true);
  });

  describe("build_filter_obj", () => {
    beforeEach(() => {
      $("#q_competence_gteq").val("01/02/2011");
      $("#q_competence_lteq").val("01/02/2013");
    });

    it("does so based on input fields", () => {
      expect(bill_filters.build_filter_obj).toEqual({
        start_date: "01/02/2011",
        end_date: "01/02/2013"
      });
    });
  });

  describe("validate", () => {
    it("returns true if a valid object is given", () => {
      expect(bill_filters.validate(BillFilterFactory.new())).toBe(true);
    });

    it("returns false if an invalid object is given", () => {
      expect(bill_filters.validate(BillFilterFactory.invalid())).toBe(false);
    });
  });

  describe("setup_listeners", () => {
    it("formats competence on form submit", () => {
      spyOn(dates, "format_competence");
      $("#search_form").trigger("submit");
      expect(dates.format_competence.calls.count()).toBe(2);
    });

    it("performs validation on form submit", () => {
      spyOn(bill_filters, "validate");
      $("#search_form").trigger("submit");
      expect(bill_filters.validate).toHaveBeenCalled();
    });
  });
});
