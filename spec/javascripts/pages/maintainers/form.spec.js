import MaintainersForm from "./../../../../app/frontend/javascripts/pages/maintainers/form";
import { remove_temp_donation, remove_temp_contact } from "./../support/maintainers";

describe("Maintainer form", () => {
  let maintainers_form;

  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = "base/spec/javascripts/fixtures";
    loadFixtures("maintainers/form.html");
    maintainers_form = new MaintainersForm();
    $.holdReady(true);
  });

  describe("update_fields_by_entity_type", () => {
    it("displays person data", () => {
      $("#maintainer_entity_type").val("person");
      maintainers_form.update_fields_by_entity_type();
      expect($("#maintainer_area")).toHaveClass("hidden");
      expect($("#person_area")).not.toHaveClass("hidden");
    });

    it("displays maintainer data", () => {
      $("#maintainer_entity_type").val("company");
      maintainers_form.update_fields_by_entity_type();
      expect($("#maintainer_area")).not.toHaveClass("hidden");
      expect($("#person_area")).toHaveClass("hidden");
    });
  });

  describe("new_donations", () => {
    it("identifies when there are new donations", () => {
      expect(maintainers_form.new_donations()).toBe(true);
    });

    it("makes sure there are no new donations", () => {
      remove_temp_donation();
      expect(maintainers_form.new_donations()).toBe(false);
    });
  });

  describe("new_contacts", () => {
    it("identifies when there are new contacts", () => {
      expect(maintainers_form.new_contacts()).toBe(true);
    });

    it("makes sure there are no new contacts", () => {
      remove_temp_contact();
      expect(maintainers_form.new_contacts()).toBe(false);
    });
  });

  describe("before_submit_or_leave", () => {
    it("returns true when there are new donations and contacts", () => {
      expect(maintainers_form.before_submit_or_leave()).toBe(true);
    });

    it("returns true when there are new donations", () => {
      remove_temp_donation();
      expect(maintainers_form.before_submit_or_leave()).toBe(true);
    });

    it("returns true when there are new contacts", () => {
      remove_temp_contact();
      expect(maintainers_form.before_submit_or_leave()).toBe(true);
    });

    it("returns false when there are no donations nor contacts", () => {
      remove_temp_donation();
      remove_temp_contact();
      expect(maintainers_form.before_submit_or_leave()).toBe(false);
    });
  });

  describe("validate", () => {
    it("returns true if a valid object is given", () => {
      const obj = { email: "example@gmail.com" };
      expect(maintainers_form.validate(obj)).toBe(true);
    });

    // Karma does not load locale;
    // it("returns false if an invalid object is given", () => {
    //   const obj = { email: "invalid_email" }
    //   expect(maintainers_form.validate(obj)).toBe(false);
    // });
  });

  describe("setup_listeners", () => {
    it("binds entity type change to corresponding fields' update", () => {
      spyOn(maintainers_form, "update_fields_by_entity_type");
      $("#maintainer_entity_type").trigger("change");
      expect(maintainers_form.update_fields_by_entity_type).toHaveBeenCalled();
    });

    it("binds form submit to preprocess function", () => {
      spyOn(maintainers_form, "before_submit_or_leave");
      $("#main_form").trigger("submit");
      expect(maintainers_form.before_submit_or_leave).toHaveBeenCalled();
    });

    it("binds form submit to form validation", () => {
      spyOn(maintainers_form, "validate");
      $("#main_form").trigger("submit");
      expect(maintainers_form.validate).toHaveBeenCalled();
    });
  });

  describe("setup_view_components", () => {
    // TODO
  });
});
