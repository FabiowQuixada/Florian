// import SystemSettingsIndex from "./../../../../app/frontend/javascripts/pages/system_settings/index";
// import * as form_commons from "./../../../../app/frontend/javascripts/pages/support/form_commons";

// describe("System settings index", () => {
//   let settings_index;

//   beforeEach(() => {
//     jasmine.getFixtures().fixturesPath = "base/spec/javascripts/fixtures";
//     loadFixtures("system_settings/index.html");
//     settings_index = new SystemSettingsIndex();
//     $.holdReady(true);
//   });

//   // TODO Use 'toHaveBeenCalled*WITH*', cant do it now because of the locale-loading problem;
//   describe("setup_listeners", () => {
//     describe("add_tag_to_field", () => {
//       it("adds 'maintainer' tag to receipt title", () => {
//         spyOn(form_commons, "add_tag_to_field");
//         $("#add_maintainer_to_re_title_btn").trigger("click");
//         expect(form_commons.add_tag_to_field).toHaveBeenCalled();
//       });

//       it("adds 'value' tag to receipt title", () => {
//         spyOn(form_commons, "add_tag_to_field");
//         $("#add_value_to_re_title_btn").trigger("click");
//         expect(form_commons.add_tag_to_field).toHaveBeenCalled();
//       });

//       it("adds 'competence' tag to receipt title", () => {
//         spyOn(form_commons, "add_tag_to_field");
//         $("#add_competence_to_re_title_btn").trigger("click");
//         expect(form_commons.add_tag_to_field).toHaveBeenCalled();
//       });

//       it("adds 'maintainer' tag to receipt body", () => {
//         spyOn(form_commons, "add_tag_to_field");
//         $("#add_maintainer_to_re_body_btn").trigger("click");
//         expect(form_commons.add_tag_to_field).toHaveBeenCalled();
//       });

//       it("adds 'value' tag to receipt body", () => {
//         spyOn(form_commons, "add_tag_to_field");
//         $("#add_value_to_re_body_btn").trigger("click");
//         expect(form_commons.add_tag_to_field).toHaveBeenCalled();
//       });

//       it("adds 'competence' tag to receipt body", () => {
//         spyOn(form_commons, "add_tag_to_field");
//         $("#add_competence_to_re_body_btn").trigger("click");
//         expect(form_commons.add_tag_to_field).toHaveBeenCalled();
//       });

//       it("adds 'competence' tag to pse title", () => {
//         spyOn(form_commons, "add_tag_to_field");
//         $("#add_competence_to_pse_title_btn").trigger("click");
//         expect(form_commons.add_tag_to_field).toHaveBeenCalled();
//       });

//       it("adds 'competence' tag to pse body", () => {
//         spyOn(form_commons, "add_tag_to_field");
//         $("#add_competence_to_pse_body_btn").trigger("click");
//         expect(form_commons.add_tag_to_field).toHaveBeenCalled();
//       });
//     });

//     // TODO boostrap modal display;
//     // it("displays tag-helper-modal on receipt-title-helper-button click", () => {
//     //   $("#receipt_title_tag_help_btn").trigger('click');
//     //   // ???
//     // });

//     // it("displays tag-helper-modal on pse-title-helper-button click", () => {
//     //   $("#pse_title_tag_help_btn").trigger('click');
//     //   // ???
//     // });

//     // it("displays tag-helper-modal on pse-title-helper-button click", () => {
//     //   $("#pse_body_tag_help_btn").trigger('click');
//     //   // ???
//     // });

//     // it("binds form submit to preprocess function", () => {
//     //   spyOn(settings_index, 'before_submit_or_leave');
//     //   $("#main_form").trigger('submit');
//     //   expect(settings_index.before_submit_or_leave).toHaveBeenCalled();
//     // });
//   });

//   describe("before_submit_or_leave", () => {
//     it("formats recipients field", () => {
//       settings_index.before_submit_or_leave();
//       expect($('#system_setting_pse_recipients_array').val()).toEqual("example1@google.com, example2@google.com");
//     });

//     it("formats private recipients field", () => {
//       settings_index.before_submit_or_leave();
//       expect($('#system_setting_pse_private_recipients_array').val()).toEqual("example3@google.com, example4@google.com");
//     });
//   });

//   describe("setup_view_components", () => {
//     // TODO
//   });
// });
