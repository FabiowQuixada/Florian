import { set_number_of_tabs, hide_all_tabs_except } from "./../../app/frontend/javascripts/pages/support/tab_commons";

describe("Tab commons", () => {
  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = "base/spec/javascripts/fixtures";
    loadFixtures("tab_commons.html");
  });

  describe("set_number_of_tabs", () => {
    describe("'main' prefix", () => {
      beforeEach(() => {
        set_number_of_tabs("main", 3);
      });

      it("activates first tab title", () => {
        expect($("#main_tab_0_title").hasClass("active")).toBe(true);
      });

      it("deactivates second tab title", () => {
        expect($("#main_tab_1_title").hasClass("active")).toBe(false);
      });

      it("deactivates third tab title", () => {
        expect($("#main_tab_2_title").hasClass("active")).toBe(false);
      });

      it("displays first tab body", () => {
        expect($("#main_tab_0").hasClass("hidden")).toBe(false);
      });

      it("hides second tab body", () => {
        expect($("#main_tab_1").hasClass("hidden")).toBe(true);
      });

      it("hides third tab body", () => {
        expect($("#main_tab_2").hasClass("hidden")).toBe(true);
      });
    });

    describe("'test' prefix", () => {
      beforeEach(() => {
        set_number_of_tabs("test", 3);
      });

      it("activates first tab title", () => {
        expect($("#test_tab_0_title").hasClass("active")).toBe(true);
      });

      it("deactivates second tab title", () => {
        expect($("#test_tab_1_title").hasClass("active")).toBe(false);
      });

      it("deactivates third tab title", () => {
        expect($("#test_tab_2_title").hasClass("active")).toBe(false);
      });

      it("displays first tab body", () => {
        expect($("#test_tab_0").hasClass("hidden")).toBe(false);
      });

      it("hides second tab body", () => {
        expect($("#test_tab_1").hasClass("hidden")).toBe(true);
      });

      it("hides third tab body", () => {
        expect($("#test_tab_2").hasClass("hidden")).toBe(true);
      });
    });
  });

  describe("hide_all_tabs_except", () => {
    describe("'main' prefix", () => {
      beforeEach(() => {
        hide_all_tabs_except("main", 1);
      });

      it("deactivates first tab title", () => {
        expect($("#main_tab_0_title").hasClass("active")).toBe(false);
      });

      it("activates second tab title", () => {
        expect($("#main_tab_1_title").hasClass("active")).toBe(true);
      });

      it("deactivates third tab title", () => {
        expect($("#main_tab_2_title").hasClass("active")).toBe(false);
      });

      it("hides first tab body", () => {
        expect($("#main_tab_0").hasClass("hidden")).toBe(true);
      });

      it("displays second tab body", () => {
        expect($("#main_tab_1").hasClass("hidden")).toBe(false);
      });

      it("hides third tab body", () => {
        expect($("#main_tab_2").hasClass("hidden")).toBe(true);
      });
    });

    describe("'test' prefix", () => {
      beforeEach(() => {
        hide_all_tabs_except("test", 1);
      });

      it("deactivates first tab title", () => {
        expect($("#test_tab_0_title").hasClass("active")).toBe(false);
      });

      it("activates second tab title", () => {
        expect($("#test_tab_1_title").hasClass("active")).toBe(true);
      });

      it("deactivates third tab title", () => {
        expect($("#test_tab_2_title").hasClass("active")).toBe(false);
      });

      it("hides first tab body", () => {
        expect($("#test_tab_0").hasClass("hidden")).toBe(true);
      });

      it("displays second tab body", () => {
        expect($("#test_tab_1").hasClass("hidden")).toBe(false);
      });

      it("hides third tab body", () => {
        expect($("#test_tab_2").hasClass("hidden")).toBe(true);
      });
    });
  });
});
