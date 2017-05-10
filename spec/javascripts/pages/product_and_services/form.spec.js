import ProductAndServiceDataForm from "./../../../../app/frontend/javascripts/pages/product_and_service_data/form";
import Constants from "./../../../../app/frontend/javascripts/server_constants";
import * as dates from "./../../../../app/frontend/javascripts/pages/support/dates";

describe("Product and service form", () => {
  let ps_data_form;

  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = "base/spec/javascripts/fixtures";
    loadFixtures("product_and_service_data/form.html");
    ps_data_form = new ProductAndServiceDataForm();
    $.holdReady(true);
  });

  describe("set_request_url", () => {
    it("calls set_hidden_week_field()", () => {
      const week_number = 4;
      spyOn(ps_data_form, "set_hidden_week_field");
      ps_data_form.set_request_url(week_number);
      expect(ps_data_form.set_hidden_week_field).toHaveBeenCalledWith("start_date", week_number);
      expect(ps_data_form.set_hidden_week_field).toHaveBeenCalledWith("end_date", week_number);
    });

    it("sets helper form url to send data to analysis", () => {
      ps_data_form.set_request_url(5);
      expect($("#hidden_week_form").attr("action")).toEqual(
        Constants.paths.send_to_analysis_product_and_service_weeks);
    });

    it("sets helper form action to send data to clients", () => {
      ps_data_form.set_request_url(6);
      expect($("#hidden_week_form").attr("action")).toEqual(
        Constants.paths.send_maintainers_product_and_service_weeks);
    });
  });

  describe("set_hidden_week_field", () => {
    beforeEach(() => {
      // Sources;
      $("#w4_week_id").val(7);
      $("#w4_week_start_date").val("01/01/0001");

      // Targets;
      $("#hiddenweek_week_id").val(0);
      $("#hiddenweek_week_start_date").val("02/02/0002");
    });

    it("does so with 'start_date' field", () => {
      ps_data_form.set_hidden_week_field("start_date", 4);
      expect($("#hiddenweek_week_start_date").val()).toEqual("01/01/0001");
    });

    it("does so with 'id' field", () => {
      ps_data_form.set_hidden_week_field("id", 4);
      expect($("#hiddenweek_week_id").val()).toEqual("7");
    });
  });

  describe("copy_to_hidden_form_and_send", () => {
    it("calls set_hidden_week_field", () => {
      const week_number = 4;
      spyOn(ps_data_form, "set_hidden_week_field");
      ps_data_form.copy_to_hidden_form_and_send(week_number);
      expect(ps_data_form.set_hidden_week_field).toHaveBeenCalledWith("id", week_number);
    });

    it("calls set_request_url()", () => {
      const week_number = 4;
      spyOn(ps_data_form, "set_request_url");
      ps_data_form.copy_to_hidden_form_and_send(week_number);
      expect(ps_data_form.set_request_url).toHaveBeenCalledWith(week_number);
    });
  });

  describe("setup_listeners", () => {
    it("binds button click to final data tab update", () => {
      spyOn(ps_data_form, "copy_from_totals_to_final_tab");
      $("#update_final_data_btn").trigger("click");
      expect(ps_data_form.copy_from_totals_to_final_tab).toHaveBeenCalled();
    });

    it("binds competence change to its formatation", () => {
      spyOn(dates, "format_competence");
      $("#aux_competence").trigger("change");
      expect(dates.format_competence).toHaveBeenCalled();
    });

    it("binds button click to week update and send", () => {
      spyOn(ps_data_form, "copy_to_hidden_form_and_send");

      for (let i = 0; i < Constants.number_of_weeks-2; i++) {
        $(`#update_and_send_btn_${i}`).trigger("click");
        expect(ps_data_form.copy_to_hidden_form_and_send).toHaveBeenCalledWith(i);
      }
    });
  });
});
