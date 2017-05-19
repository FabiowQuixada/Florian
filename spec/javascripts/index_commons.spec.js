/**
 *
 * 
 * There is some problem when loading 'new IndexCommons();'
 *
 *
**/



// import IndexCommons from './../../app/frontend/javascripts/index_commons';

// describe("Index commons", () => {
//   let index_commons;

//   beforeEach(() => {
//     jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures';
//     loadFixtures('index_commons.html');
//     index_commons = new IndexCommons();
//     $.holdReady(true);
//   });

//   describe("setup_filter_panel", () => {
//     it("expands filter panel if any field is filled", () => {
//       $('#some_filter').val('');
//       index_commons.setup_filter_panel();
//       expect($('#index_filters').attr("aria-expanded")).toEqual('true');
//     });

//     it("keeps filter panel closed if no field is filled", () => {
//       $('#some_filter').val('some_value');
//       index_commons.setup_filter_panel();
//       expect($('#index_filters').attr("aria-expanded")).toEqual('false');
//     });
//   });

//   describe("setup_listeners", () => {
//     // TODO
//   });

//   describe("update_status", () => {
//     // TODO
//   });

//   describe("status_path", () => {
//     it("returns the deactivate path for receipt e-mails", () => {
//       expect(index_commons.status_path('receipt_emails', 2, 0)).toEqual('/receipt_emails/2/deactivate');
//     });

//     it("returns the activate path for receipt e-mails", () => {
//       expect(index_commons.status_path('receipt_emails', 3, 1)).toEqual('/receipt_emails/3/activate');
//     });

//     it("returns the deactivate path for maintainers", () => {
//       expect(index_commons.status_path('maintainers', 4, 0)).toEqual('/maintainers/4/deactivate');
//     });

//     it("returns the activate path for maintainers", () => {
//       expect(index_commons.status_path('maintainers', 5, 1)).toEqual('/maintainers/5/activate');
//     });
//   });

//   describe("destroy_model", () => {
//     // TODO
//   });
// });
