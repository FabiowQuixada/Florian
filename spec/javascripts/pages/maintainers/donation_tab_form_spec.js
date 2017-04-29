// import MaintainersForm from './../../../app/frontend/javascripts/maintainers/form.jsx'

// describe("Donation tab", () => {
//   const empty_donation = {
//     donation_date: '',
//     value: '',
//     remark: '',
//   }

//   const date_only_donation = {
//     donation_date: '01/02/2013',
//     value: '',
//     remark: '',
//   }

//   beforeEach(() => {
//     jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures';
//     loadFixtures('maintainers/donation_tab_form.html');
//     new MaintainersForm();
//     new MaintainersDonationTabForm();
//   });

//   it("builds a donation object based on user inputs", () => {
//     const donation = build_donation();
//     const expected = {
//       id: -1,
//       donation_date: '01/02/2013',
//       value: '3',
//       remark: '4',
//     }

//     expect(donation).toEqual(expected);
//   });

//   it("validates a donation", () => {
//     expect(validate_donation(build_donation())).toEqual(true);
//     expect(validate_donation(empty_donation)).toEqual(false);
//     expect(validate_donation(date_only_donation)).toEqual(false);
//   });

//   it("cleans donation form", () => {
//     clean_donation_fields();

//     expect($(`#donation_error_messages`).html()).toEqual("");
//     expect($(`#donation_error_box`)).toHaveClass('hidden');
//   });
// });