/**
 *
 *    All tests depend on Karma loading Bootstrap, which does not happen due to some config problem
 *
**/

// import ReceiptEmailsIndex from "./../../../../app/frontend/javascripts/pages/receipt_emails/index";
// import * as receipt_modal from "./../../../../app/frontend/javascripts/pages/receipt_emails/modals";
// import ReceiptEmailFactory from "./../../../../app/frontend/javascripts/factories/ReceiptEmailFactory";
// import ReceiptEmailHistoryFactory from "./../../../../app/frontend/javascripts/factories/ReceiptEmailHistoryFactory";

// describe("Receipt e-mail index", () => {
//   let receipt_index;

//   beforeEach(() => {
//     jasmine.getFixtures().fixturesPath = "base/spec/javascripts/fixtures";
//     receipt_index = new ReceiptEmailsIndex();
//     loadFixtures("receipt_emails/index.html");
//     $.holdReady(true);
//   });

//   describe("setup_listeners", () => {
//     describe("resend button", () => {
//       it("cleans modal data", () => {
//         spyOn(receipt_modal, 'clean_resend_modal');
//         $(".resend_btn").first().trigger('click');
//         expect(receipt_modal.clean_resend_modal).toHaveBeenCalled();
//       });

//       it("displays company name in modal", () =>{
//         $(".resend_btn").first().trigger('click');
//         expect($("#resend_email_modal .modal_maintainer_name").first().html()).toEqual('Gleason-Rohan');
//       });

//       it("sets company id in modal", () =>{
//         $(".resend_btn").first().trigger('click');
//         expect($("#receipt_email_id").val()).toEqual('4');
//       });

//       it("shows resend modal", () =>{
//         $(".resend_btn").first().trigger('click');
//         // ???
//       });
//     });

//     describe("send test button", () => {
//       it("cleans modal data", () => {
//         spyOn(receipt_modal, 'clean_send_test_modal');
//         $(".send_test_btn").first().trigger('click');
//         expect(receipt_modal.clean_send_test_modal).toHaveBeenCalled();
//       });

//       it("displays company name in modal", () =>{
//         $(".send_test_btn").first().trigger('click');
//         expect($("#send_test_email_modal .modal_maintainer_name").first().html()).toEqual('Gleason-Rohan');
//       });

//       it("sets company id in modal", () =>{
//         $(".send_test_btn").first().trigger('click');
//         expect($("#receipt_email_id").val()).toEqual('4');
//       });

//       it("shows send test modal", () =>{
//         $(".send_test_btn").first().trigger('click');
//         // ???
//       });
//     });

//     it("displays recent e-mails modal", () =>{
//       $("#recent_emails_btn").trigger('click');
//       // ???
//     });
//   });
// });
