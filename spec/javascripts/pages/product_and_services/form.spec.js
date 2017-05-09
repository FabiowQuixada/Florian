import ProductAndServiceDataForm from './../../../../app/frontend/javascripts/product_and_service_data/form';
import Constants from './../../../../app/frontend/javascripts/server_constants';

describe("Product and service form", () => {
  let ps_data_form;

  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures';
    loadFixtures('product_and_service_data/form.html');
    ps_data_form = new ProductAndServiceDataForm();
    $.holdReady(true);
  });

  describe("update_product_totals_from_tab", () => {
    beforeEach(() => {
      $('#total_product_week_2').val(0);
    });

    it("does so", () => {
      $('#prod_0_week_2').val(1);
      $('#prod_1_week_2').val(2);
      $('#prod_2_week_2').val(4);

      ps_data_form.update_product_totals_from_tab(2);
      expect($('#total_product_week_2').val()).toEqual('7');
    });
  });

  describe("update_service_totals_from_tab", () => {
    beforeEach(() => {
      $(`#total_service_checkup_week_3`).val(0);
      $(`#total_service_return_week_3`).val(-4);
      $(`#total_service_week_3`).val(0);

      $('#row_0 .service_checkup').val(2);
      $('#row_0 .service_return').val(5);
      $('#row_1 .service_checkup').val(4);
      $('#row_1 .service_return').val(9);
    });

    // it("updates row's total", () => {
    //   ps_data_form.update_service_totals_from_tab(3);
    //   expect($('.service-3-row.service_total').val()).toEqual('7');
    // });

    // it("updates row's total", () => {
    //   expect($(`#row_1 .service_total`).val()).toEqual('13');
    // });

    // it("updates week's total checkups", () => {
    //   expect($(`#total_service_checkup_week_3`).val()).toEqual('6');
    // });

    // it("updates week's total returns", () => {
    //   expect($(`#total_service_return_week_3`).val()).toEqual('14');
    // });

    // it("updates week's totals", () => {
    //   expect($(`#total_service_week_3`).val()).toEqual('20');
    // });
  });

  describe("update_service_totals_for_each_tab", () => {
    it("calls update_service_totals_from_tab()", () => {
      spyOn(ps_data_form, "update_service_totals_from_tab");
      ps_data_form.update_service_totals_for_each_tab();

      for (let i = 0; i <= Constants.week_final_number; i++) {
        expect(ps_data_form.update_service_totals_from_tab).toHaveBeenCalledWith(i);
      }
    });

    it("calls update_totals_tab()", () => {
      spyOn(ps_data_form, "update_totals_tab");
      ps_data_form.update_service_totals_for_each_tab();
      expect(ps_data_form.update_totals_tab).toHaveBeenCalled();
    });
  });

  describe("update_product_totals_for_each_tab", () => {
    it("calls update_product_totals_from_tab()", () => {
      spyOn(ps_data_form, "update_product_totals_from_tab");
      ps_data_form.update_product_totals_for_each_tab();

      for (let i = 0; i <= Constants.week_final_number; i++) {
        expect(ps_data_form.update_product_totals_from_tab).toHaveBeenCalledWith(i);
      }
    });

    it("calls update_totals_tab()", () => {
      spyOn(ps_data_form, "update_totals_tab");
      ps_data_form.update_product_totals_for_each_tab();
      expect(ps_data_form.update_totals_tab).toHaveBeenCalled();
    });
  });

  describe("update_totals_tab", () => {
    it("calls update_product_totals_from_tab()", () => {
      spyOn(ps_data_form, "update_product_totals_from_tab");
      ps_data_form.update_totals_tab();
      expect(ps_data_form.update_product_totals_from_tab).toHaveBeenCalled();
    });

    it("calls update_service_totals_from_tab()", () => {
      spyOn(ps_data_form, "update_service_totals_from_tab");
      ps_data_form.update_totals_tab();
      expect(ps_data_form.update_service_totals_from_tab).toHaveBeenCalled();
    });

    it("calls update_services_in_totals_tab()", () => {
      spyOn(ps_data_form, "update_services_in_totals_tab");
      ps_data_form.update_totals_tab();
      expect(ps_data_form.update_services_in_totals_tab).toHaveBeenCalled();
    });

    it("calls update_products_in_totals_tab()", () => {
      spyOn(ps_data_form, "update_products_in_totals_tab");
      ps_data_form.update_totals_tab();
      expect(ps_data_form.update_products_in_totals_tab).toHaveBeenCalled();
    });
  });

  describe("update_services_in_totals_tab", () => {
    it("does so", () => {
      $('#serv_0').val(7);
      $('#serv_2').val(2);
      ps_data_form.update_services_in_totals_tab(3, 0);

      expect($(`.service_row_3_col_0.week_5`).val()).toEqual('9');
    });
  });

  describe("update_products_in_totals_tab", () => {
    it("does so", () => {
      $('#prod_0').val(7);
      $('#prod_1').val(8);
      ps_data_form.update_products_in_totals_tab(4);
      expect($('.product_row_4.week_5').val()).toEqual('15');
    });
  });

  describe("copy_from_totals_to_final_tab", () => {
    it("calls update_product_totals_from_tab()", () => {
      spyOn(ps_data_form, "update_product_totals_from_tab");
      ps_data_form.copy_from_totals_to_final_tab();
      expect(ps_data_form.update_product_totals_from_tab).toHaveBeenCalledWith(6);
    });

    it("calls update_service_totals_from_tab()", () => {
      spyOn(ps_data_form, "update_service_totals_from_tab");
      ps_data_form.copy_from_totals_to_final_tab();
      expect(ps_data_form.update_service_totals_from_tab).toHaveBeenCalledWith(6);
    });
  });

  describe("set_request_url", () => {
    it("calls update_hidden_week_field()", () => {
      const week_number = 4;
      spyOn(ps_data_form, "update_hidden_week_field");
      ps_data_form.set_request_url(week_number);
      expect(ps_data_form.update_hidden_week_field).toHaveBeenCalledWith('start_date', week_number);
      expect(ps_data_form.update_hidden_week_field).toHaveBeenCalledWith('end_date', week_number);
    });

    it("sets helper form url to send data to analysis", () => {
      ps_data_form.set_request_url(5);
      expect($('#hidden_week_form').attr('action')).toEqual(
        Constants.paths.send_to_analysis_product_and_service_weeks);
    });

    it("sets helper form action to send data to clients", () => {
      ps_data_form.set_request_url(6);
      expect($('#hidden_week_form').attr('action')).toEqual(
        Constants.paths.send_maintainers_product_and_service_weeks);
    });
  });

  describe("update_hidden_serv_field", () => {
    it("", () => {

    });

    it("", () => {

    });
  });

  describe("update_hidden_prod_field", () => {
    it("", () => {

    });

    it("", () => {

    });
  });

  describe("update_hidden_week_field", () => {
    it("", () => {

    });

    it("", () => {

    });
  });

  describe("copy_to_hidden_form_and_send", () => {
    it("calls update_hidden_prod_field()", () => {
      const week_number = 4;
      spyOn(ps_data_form, "update_hidden_prod_field");
      ps_data_form.copy_to_hidden_form_and_send(week_number);
      expect(ps_data_form.update_hidden_prod_field).toHaveBeenCalled();
    });

    it("calls update_hidden_serv_field()", () => {
      const week_number = 4;
      spyOn(ps_data_form, "update_hidden_serv_field");
      ps_data_form.copy_to_hidden_form_and_send(week_number);
      expect(ps_data_form.update_hidden_serv_field).toHaveBeenCalled();
    });

    it("calls update_hidden_week_field", () => {
      const week_number = 4;
      spyOn(ps_data_form, "update_hidden_week_field");
      ps_data_form.copy_to_hidden_form_and_send(week_number);
      expect(ps_data_form.update_hidden_week_field).toHaveBeenCalled();
    });

    it("calls update_hidden_serv_field()", () => {
      // All service fields plus 'id' field, one time
      // for each type of service (checkup and return);
      const number_of_services = (Constants.services_array.length+1)*2;

      const week_number = 4;
      spyOn(ps_data_form, "update_hidden_serv_field");
      ps_data_form.copy_to_hidden_form_and_send(week_number);
      expect(ps_data_form.update_hidden_serv_field.calls.count()).toEqual(number_of_services);
    });

    it("calls update_hidden_prod_field()", () => {
      const number_of_products = Constants.products_array.length;
      const week_number = 4;
      spyOn(ps_data_form, "update_hidden_prod_field");
      ps_data_form.copy_to_hidden_form_and_send(week_number);
      expect(ps_data_form.update_hidden_prod_field.calls.count()).toEqual(number_of_products+1);
    });

    it("calls set_request_url()", () => {
      const week_number = 4;
      spyOn(ps_data_form, "set_request_url");
      ps_data_form.copy_to_hidden_form_and_send(week_number);
      expect(ps_data_form.set_request_url).toHaveBeenCalledWith(week_number);
    });
  });

  describe("setup_listeners", () => {
    // TODO
  });
});
