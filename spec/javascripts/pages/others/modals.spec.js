/**
 *
 * TODO: Bootstrap is for some reason not recognized in the tests;
 *
**/

// import { display_confirm_modal } from './../../../../app/frontend/javascripts/pages/support/modals';

// describe("Modal", () => {
//   const title = "Some title";
//   const msg = "Some weird message";
//   const confirm_callback = () => {};
//   const cancel_callback = () => {};

//   beforeEach(() => {
//     jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures';
//     loadFixtures('others/modals.html');
//     $.holdReady(true);
//   });

//   it("pops-up", () => {
//     // TODO
//   });

//   describe("texts", () => {
//     beforeEach(() => {
//       display_confirm_modal(title, msg);
//     });

//     it("displays title", () => {
//       // expect($('#confirm_modal .modal-title').html()).toEqual(title);
//     });

//     it("displays message", () => {
//       // expect($('#confirm_modal .modal-body').html()).toEqual(msg);
//     });
//   });

//   describe("absence of callback parameters", () => {
//     beforeEach(() => {
//       display_confirm_modal(title, msg);
//     });

//     it("does not display modal footer", () => {
//       expect($("#confirm_modal .modal-footer").hasClass('hidden')).toBe(true);
//     });
//   });

//   describe("with only confirm callback", () => {
//     beforeEach(() => {
//       display_confirm_modal(title, msg, confirm_callback);
//     });

//     it("confirm button is bound to confirm callback", () => {
//       // TODO
//     });

//     it("does not display cancel button", () => {
//       expect($('#cancel_btn').hasClass('hidden')).toBe(true);
//     });
//   });

//   describe("with both confirm and cancel callbacks", () => {
//     beforeEach(() => {
//       display_confirm_modal(title, msg, confirm_callback, cancel_callback);
//     });

//     it("confirm button is bound to confirm callback", () => {
//       // TODO
//     });

//     it("does not display cancel button", () => {
//       expect($('#cancel_btn').hasClass('hidden')).toBe(true);
//     });

//     it("cancel button is bound to cancel callback", () => {
//       // TODO
//     });

//     it("does not display cancel button", () => {
//       expect($('#cancel_btn').hasClass('hidden')).toBe(false);
//     });
//   });
// });
