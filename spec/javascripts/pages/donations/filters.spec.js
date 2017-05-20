import DonationFilters from "./../../../../app/frontend/javascripts/pages/donations/filters";
import DonationFilterFactory from "./../../../../app/frontend/javascripts/factories/DonationFilterFactory";

describe("Donation filters", () => {
  let donation_filters;

  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = "base/spec/javascripts/fixtures";
    loadFixtures("donations/filters.html");
    donation_filters = new DonationFilters();
    $.holdReady(true);
  });

  describe("build_filter_obj", () => {
    beforeEach(() => {
      $("#q_donation_date_gteq").val("02/01/2011");
      $("#q_donation_date_lteq").val("02/01/2013");
    });

    it("does so based on input fields", () => {
      expect(donation_filters.build_filter_obj()).toEqual({
        start_date: "2011-02-01",
        end_date: "2013-02-01"
      });
    });
  });

  describe("validate", () => {
    it("returns true if a valid object is given", () => {
      expect(donation_filters.validate(DonationFilterFactory.new())).toBe(true);
    });

    it("returns false if an invalid object is given", () => {
      expect(donation_filters.validate(DonationFilterFactory.invalid())).toBe(false);
    });
  });

  describe("setup_listeners", () => {
    it("performs validation on form submit", () => {
      spyOn(donation_filters, "validate");
      $("#search_form").trigger("submit");
      expect(donation_filters.validate).toHaveBeenCalled();
    });
  });
});
