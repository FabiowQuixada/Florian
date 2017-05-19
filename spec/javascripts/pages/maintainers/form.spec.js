/** 
 *
 *  TODO These tests work, but some lines of code in some files
 *  have to be removed for it to work. This is a React issue;
 *
**/

// import MaintainersForm from './../../../../app/frontend/javascripts/maintainers/form';
// import { remove_temp_donation, remove_temp_contact } from './../support/maintainers';

// describe("Maintainer form", () => {
//   let maintainers_form;

//   beforeEach(() => {
//     jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures';
//     loadFixtures('maintainers/form.html');
//     maintainers_form = new MaintainersForm();
//     $.holdReady(true);
//   });

//   describe("update_fields_by_entity_type", () => {
//     it("displays person data", () => {
//       $("#maintainer_entity_type").val("person");
//       maintainers_form.update_fields_by_entity_type();
//       expect($('#maintainer_area')).toHaveClass('hidden');
//       expect($('#person_area')).not.toHaveClass('hidden');
//     });

//     it("displays maintainer data", () => {
//       $("#maintainer_entity_type").val("company");
//       maintainers_form.update_fields_by_entity_type();
//       expect($('#maintainer_area')).not.toHaveClass('hidden');
//       expect($('#person_area')).toHaveClass('hidden');
//     });
//   });

//   describe("new_donations", () => {
//     it("identifies when there are new donations", () => {
//       expect(maintainers_form.new_donations()).toEqual(true);
//     });

//     it("makes sure there are no new donations", () => {
//       remove_temp_donation();
//       expect(maintainers_form.new_donations()).toEqual(false);
//     });
//   });

//   describe("new_contacts", () => {
//     it("identifies when there are new constacts", () => {
//       expect(maintainers_form.new_contacts()).toEqual(true);
//     });

//     it("makes sure there are no new contacts", () => {
//       remove_temp_contact();
//       expect(maintainers_form.new_contacts()).toEqual(false);
//     });
//   });

//   describe("before_submit_or_leave", () => {
//     it("returns true when there are new donations and contacts", () => {
//       expect(maintainers_form.before_submit_or_leave()).toEqual(true);
//     });

//     it("returns true when there are new donations", () => {
//       remove_temp_donation();
//       expect(maintainers_form.before_submit_or_leave()).toEqual(true);
//     });

//     it("returns true when there are new contacts", () => {
//       remove_temp_contact();
//       expect(maintainers_form.before_submit_or_leave()).toEqual(true);
//     });

//     it("returns false when there are no donations nor contacts", () => {
//       remove_temp_donation();
//       remove_temp_contact();
//       expect(maintainers_form.before_submit_or_leave()).toEqual(false);
//     });
//   });

//   describe("setup_listeners", () => {
//     // TODO
//   });

//   describe("setup_view_components", () => {
//     // TODO
//   });
// });
