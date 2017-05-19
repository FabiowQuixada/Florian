import emails from './../../../app/frontend/javascripts/redux/reducers/emailsReducer';
import * as actions from './../../../app/frontend/javascripts/redux/actions/emailsActionCreators';
// import I18n from './../../../app/frontend/javascripts/i18n';

const deepFreeze = require('deep-freeze');

describe("E-mails reducer", () => {
  let action;
  let stateBefore;
  let stateAfter;

  afterEach(() => {
    deepFreeze(stateBefore);
    deepFreeze(action);
    expect(emails(stateBefore, action)).toEqual(stateAfter);
  });

  describe("ADD action", () => {
    it("adds a valid e-mail", () => {
      const email = "example@gmail.com";
      action = actions.add(email);
      stateBefore = {
        errors: [],
        email_field: email,
        rows: []
      };
      stateAfter = {
        errors: [],
        email_field: '',
        rows: [{
          is_persisted: "false",
          address: email
        }]
      };
    });

    // TODO Locale is not loaded with Karma;
    // it("prevents adition of an invalid e-mail", () => {
    //   const attribute = I18n.t('activerecord.attributes.contact.email_address');
    //   const msg = I18n.t('errors.messages.invalid', { attribute: attribute });

    //   const email = "examplegmail.com";
    //   action = actions.add(email);
    //   stateBefore = {
    //     errors: [],
    //     email_field: email,
    //     rows: []
    //   };
    //   stateAfter = {
    //     errors: [msg],
    //     email_field: email,
    //     rows: []
    //   };
    // });
  });

  describe("REMOVE action", () => {
    it("removes an e-mail from the list", () => {
      const email1 = "example_1@gmail.com";
      const email2 = "example_2@gmail.com";
      action = actions.remove(email1);
      stateBefore = {
        errors: [],
        email_field: '',
        rows: [email1, email2]
      };
      stateAfter = {
        errors: [],
        email_field: '',
        rows: [email2]
      };
    });
  });
});
