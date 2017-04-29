// describe("Contact tab", () => {
//   const empty_contact = {
//     id: -1,
//     name: '',
//     position: '',
//     email_address: '',
//     telephone: '',
//     celphone: '',
//     fax: ''
//   }

//   const invalid_email_contact = {
//     id: -1,
//     name: '',
//     position: 'boss',
//     email_address: 'im not an e-mail',
//     telephone: '',
//     celphone: '',
//     fax: ''
//   }

//   beforeEach(() => {
//     jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures';
//     loadFixtures('maintainers/contact_tab_form.html');
//     maintainers_form();
//     maintainers_contact_tab_form();
//   });


//   it("builds a contact object based on user inputs", () => {
//     const expected = {
//       id: -2,
//       name: '2',
//       position: '3',
//       email_address: 'foo@gmail.com',
//       telephone: '5',
//       celphone: '6',
//       fax: '7'
//     }

//     expect(build_contact()).toEqual(expected);
//   });

//   it("verifies if a contact is empty", () => {
//     expect(at_least_one_field_filled(build_contact())).toEqual(true);
//     expect(at_least_one_field_filled(empty_contact)).toEqual(false);
//   });

//   it("validates a contact", () => {
//     expect(validate_contact(build_contact())).toEqual(true);
//     expect(validate_contact(empty_contact)).toEqual(false);
//     expect(validate_contact(invalid_email_contact)).toEqual(false);
//   });

//   it("cleans contact form", () => {
//     clean_contact_fields();

//     expect($('#add_contact_btn').html()).toEqual(I18n.t('helpers.action.add'));
//     expect($('#cancel_contact_edition_btn')).toHaveClass('hidden');
//     expect($('#contact_panel_header').html()).toEqual(I18n.t('helpers.maintainer.new_contact'));

//     expect($('#contact_error_messages').html()).toEqual("");
//     expect($('#contact_error_box')).toHaveClass('hidden');
//   });
// });