/**
 *
 *    Most tests depend on Karma loading Bootstrap, which does not happen due to some config problem
 *
**/

// import IndexCommons from "./../../app/frontend/javascripts/pages/support/index_commons";
// // import ReceiptEmailResponses from "./ajax_responses/receipt_email_responses";
// // import ServerFunctions from "./../../app/frontend/javascripts/server_functions";
// // import { display_confirm_modal } from './../../app/frontend/javascripts/pages/support/modals';

// describe("Index commons", () => {
//   let index_commons;

//   beforeEach(() => {
//     jasmine.getFixtures().fixturesPath = "base/spec/javascripts/fixtures";
//     loadFixtures("index_commons.html");
//     index_commons = new IndexCommons();
//     $.holdReady(true);
//   });

//   // describe("setup_filter_panel", () => {
//   //   it("expands filter panel if any field is filled", () => {
//   //     $('#some_filter').val('');
//   //     index_commons.setup_filter_panel();
//   //     expect($('#index_filters').attr("aria-expanded")).toEqual('true');
//   //   });

//   //   it("keeps filter panel closed if no field is filled", () => {
//   //     $('#some_filter').val('some_value');
//   //     index_commons.setup_filter_panel();
//   //     expect($('#index_filters').attr("aria-expanded")).toEqual('false');
//   //   });
//   // });

//   describe("status_path", () => {
//     it("returns the deactivate path for receipt e-mails", () => {
//       expect(index_commons.status_path("receipt_emails", 2, false)).toEqual("/receipt_emails/2/activate");
//     });

//     it("returns the activate path for receipt e-mails", () => {
//       expect(index_commons.status_path("receipt_emails", 3, true)).toEqual("/receipt_emails/3/deactivate");
//     });

//     it("returns the deactivate path for maintainers", () => {
//       expect(index_commons.status_path("maintainers", 4, false)).toEqual("/maintainers/4/activate");
//     });

//     it("returns the activate path for maintainers", () => {
//       expect(index_commons.status_path("maintainers", 5, true)).toEqual("/maintainers/5/deactivate");
//     });
//   });

//   // TODO Locale is not loaded with Karma;
//   // describe("update_view", () => {
//   //   const activation_response = ReceiptEmailResponses.success.activated;
//   //   const deactivation_response = ReceiptEmailResponses.success.deactivated;
//   //   const deactivate_btn = ServerFunctions.buttons.deactivate('receipt_email', activation_response.id);
//   //   const activate_btn = ServerFunctions.buttons.activate('receipt_email', deactivation_response.id);

//   //   it("displays a 'deactivate' button", () => {
//   //     const column_content = $(`tr#model_${activation_response.id} td.status`).html;
//   //     index_commons.update_view(activation_response);
//   //     expect(column_content).toEqual(deactivate_btn);
//   //   });

//   //   it("displays an 'activate' button", () => {
//   //     const column_content = $(`tr#model_${deactivation_response.id} td.status`).html;
//   //     index_commons.update_view(deactivation_response);
//   //     expect(column_content).toEqual(activate_btn);
//   //   });
//   // });

//   describe("remove_row", () => {
//     it("does so", () => {
//       expect($("#model_1")).toExist();
//       index_commons.remove_row(1);
//       expect($("#model_1")).not.toExist();
//     });

//     it("displays a message if there are no more rows", () => {
//       index_commons.remove_row(1);
//       index_commons.remove_row(4);
//       expect($("#no_receipt_emails_row").hasClass("hidden")).toBe(false);
//     });
//   });

//   describe("setup_listeners", () => {
//     it("binds status button click to model status change", () => {
//       spyOn(index_commons, "update_status");
//       $("#index_table tbody .status_btn").first().trigger("click");
//       expect(index_commons.update_status).toHaveBeenCalled();
//     });

//     // TODO Expect to change 'window.location';
//     // it("binds fliter button click to window location update", () => {
//     //   $("#index_filters .filter_btn").first().trigger('click');
//     // });

//     // it("binds destroy button click to modal display", () => {
//     //   spyOn(modals, 'display_confirm_modal');
//     //   $("#index_table tbody .destroy_btn").first().trigger('click');
//     //   expect(modals.display_confirm_modal).toHaveBeenCalled();
//     // });
//   });
// });
