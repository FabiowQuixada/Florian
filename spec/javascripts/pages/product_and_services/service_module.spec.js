import * as service_module from "./../../../../app/frontend/javascripts/pages/product_and_service_data/service_module";
import { fill_tab_3, fill_tab_4, fill_final_tab } from "./../support/services";

describe("Service module", () => {
  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = "base/spec/javascripts/fixtures";
    loadFixtures("product_and_service_data/service_module.html");
    $.holdReady(true);
  });

  describe("update_totals_from_tab", () => {
    beforeEach(() => {
      fill_tab_3();
      fill_tab_4();
      fill_final_tab();
      service_module.update_totals_from_tab(3);
      service_module.update_totals_from_tab(4);
      service_module.update_totals_from_tab(6);
    });

    describe("for tab 3", () => {
      it("updates psychology total column", () => {
        expect($("#w3_service_psychology_total").val()).toEqual("3");
      });

      it("updates physiotherapy total column", () => {
        expect($("#w3_service_physiotherapy_total").val()).toEqual("12");
      });

      it("updates checkup total", () => {
        expect($("#w3_service_checkup_total").val()).toEqual("5");
      });

      it("updates return total", () => {
        expect($("#w3_service_return_total").val()).toEqual("10");
      });

      it("updates absolute total", () => {
        expect($("#w3_service_absolute_total").val()).toEqual("15");
      });
    });

    describe("for tab 4", () => {
      it("updates psychology total column", () => {
        expect($("#w4_service_psychology_total").val()).toEqual("48");
      });

      it("updates physiotherapy total column", () => {
        expect($("#w4_service_physiotherapy_total").val()).toEqual("192");
      });

      it("update checkup total", () => {
        expect($("#w4_service_checkup_total").val()).toEqual("80");
      });

      it("updates return total", () => {
        expect($("#w4_service_return_total").val()).toEqual("160");
      });

      it("updates absolute total", () => {
        expect($("#w4_service_absolute_total").val()).toEqual("240");
      });
    });

    describe("for final tab", () => {
      it("updates psychology total column", () => {
        expect($("#w6_service_psychology_total").val()).toEqual("768");
      });

      it("updates physiotherapy total column", () => {
        expect($("#w6_service_physiotherapy_total").val()).toEqual("3072");
      });

      it("update checkup total", () => {
        expect($("#w6_service_checkup_total").val()).toEqual("1280");
      });

      it("updates return total", () => {
        expect($("#w6_service_return_total").val()).toEqual("2560");
      });

      it("updates absolute total", () => {
        expect($("#w6_service_absolute_total").val()).toEqual("3840");
      });
    });
  });

  describe("set_hidden_week_field", () => {
    it("updates 'id' field in hidden form", () => {
      $("#w1_service_id_c0").val(7);
      service_module.set_hidden_week_field("id", 0, 1);
      expect($("#hiddenweek_service_id_c0").val()).toEqual("7");
    });

    it("updates 'psychology' field in hidden form", () => {
      $("#w2_service_psychology_c1").val(13);
      service_module.set_hidden_week_field("psychology", 1, 2);
      expect($("#hiddenweek_service_psychology_c1").val()).toEqual("13");
    });
  });

  describe("update_totals_tab", () => {
    beforeEach(() => {
      fill_tab_3();
      fill_tab_4();
      service_module.update_totals_tab();
    });

    it("updates psychology checkup field", () => {
      expect($("#w5_service_psychology_c0").val()).toEqual("17");
    });

    it("updates psychology return field", () => {
      expect($("#w5_service_psychology_c1").val()).toEqual("34");
    });

    it("update checkup total", () => {
      expect($("#w5_service_checkup_total").val()).toEqual("85");
    });

    it("updates return total", () => {
      expect($("#w5_service_return_total").val()).toEqual("170");
    });

    it("updates absolute total", () => {
      expect($("#w5_service_absolute_total").val()).toEqual("255");
    });
  });

  describe("copy_data_from_totals_to_final_tab", () => {
    beforeEach(() => {
      fill_tab_3();
      fill_tab_4();
      service_module.update_totals_tab();
      service_module.copy_data_from_totals_to_final_tab();
      service_module.update_totals_from_tab(6);
    });

    it("updates psychology checkup", () => {
      expect($("#w6_service_psychology_c0").val()).toEqual("17");
    });

    it("updates psychology return", () => {
      expect($("#w6_service_psychology_c1").val()).toEqual("34");
    });

    it("update checkup total", () => {
      expect($("#w6_service_checkup_total").val()).toEqual("85");
    });

    it("updates return total", () => {
      expect($("#w6_service_return_total").val()).toEqual("170");
    });

    it("updates absolute total", () => {
      expect($("#w6_service_absolute_total").val()).toEqual("255");
    });
  });

  // TODO Don't know why this won't work;
  // describe("setup_listeners", () => {
  //   it("binds totals tab update to service input change", () => {
  //     spyOn(service_module, "update_totals_for_each_tab");
  //     service_module.setup_listeners();
  //     $("#w3_service_psychology_c0").trigger("change");
  //     expect(service_module.update_totals_for_each_tab).toHaveBeenCalled();
  //   });
  // });
});
