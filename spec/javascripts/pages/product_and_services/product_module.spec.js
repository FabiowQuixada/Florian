import * as product_module from "./../../../../app/frontend/javascripts/pages/product_and_service_data/product_module";
import { fill_tab_3, fill_tab_4, fill_final_tab } from "./../support/products";

describe("Product module", () => {
  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = "base/spec/javascripts/fixtures";
    loadFixtures("product_and_service_data/product_module.html");
    $.holdReady(true);
  });

  describe("update_totals_from_tab", () => {
    beforeEach(() => {
      fill_tab_3();
      fill_tab_4();
      fill_final_tab();
      product_module.update_totals_from_tab(3);
      product_module.update_totals_from_tab(4);
      product_module.update_totals_from_tab(6);
    });

    it("updates tab 3 total", () => {
      expect($("#w3_product_total").val()).toEqual("3");
    });

    it("updates tab 4 total", () => {
      expect($("#w4_product_total").val()).toEqual("12");
    });

    it("updates final tab total", () => {
      expect($("#w6_product_total").val()).toEqual("48");
    });
  });

  describe("copy_data_from_totals_to_final_tab", () => {
    beforeEach(() => {
      fill_tab_3();
      fill_tab_4();
      product_module.update_totals_from_tab(3);
      product_module.update_totals_from_tab(4);
      product_module.update_totals_tab();
      product_module.copy_data_from_totals_to_final_tab();
    });

    it("updates row 0", () => {
      expect($("#w6_product_mesh").val()).toEqual("5");
    });

    it("updates row 1", () => {
      expect($("#w6_product_cream").val()).toEqual("10");
    });

    it("update total row", () => {
      expect($("#w6_product_total").val()).toEqual("15");
    });
  });

  describe("set_hidden_week_field", () => {
    it("updates 'id' field in hidden form", () => {
      $("#w1_product_id").val(7);
      product_module.set_hidden_week_field("id", 1);
      expect($("#hiddenweek_product_id").val()).toEqual("7");
    });

    it("updates 'mesh' field in hidden form", () => {
      $("#w2_product_mesh").val(13);
      product_module.set_hidden_week_field("mesh", 2);
      expect($("#hiddenweek_product_mesh").val()).toEqual("13");
    });
  });

  describe("update_totals_tab", () => {
    beforeEach(() => {
      fill_tab_3();
      fill_tab_4();
      product_module.update_totals_from_tab(3);
      product_module.update_totals_from_tab(4);
      product_module.update_totals_tab();
    });

    it("updates row 0", () => {
      expect($("#w5_product_mesh").val()).toEqual("5");
    });

    it("updates row 1", () => {
      expect($("#w5_product_cream").val()).toEqual("10");
    });

    it("update total row", () => {
      expect($("#w5_product_total").val()).toEqual("15");
    });
  });

  // Don't know why this won't work;
  // describe("setup_listeners", () => {
  //   it("binds totals tab update to product input change", () => {
  //     spyOn(product_module, "update_totals_for_each_tab");
  //     product_module.setup_listeners();
  //     $(".product_input").first().trigger("change");
  //     expect(product_module.update_totals_for_each_tab).toHaveBeenCalled();
  //   });
  // });
});
