import contacts from "./../../../app/frontend/javascripts/redux/reducers/contactsReducer";
import * as actions from "./../../../app/frontend/javascripts/redux/actions/contactsActionCreators";
import ContactFactory from "./../../../app/frontend/javascripts/factories/ContactFactory";
import I18n from "./../../../app/frontend/javascripts/i18n";

const deepFreeze = require("deep-freeze");

describe("Contacts reducer", () => {
  let action;
  let stateBefore;
  let stateAfter;

  afterEach(() => {
    deepFreeze(stateBefore);
    deepFreeze(action);
    expect(contacts(stateBefore, action)).toEqual(stateAfter);
  });

  describe("ADD action", () => {
    it("adds a valid contact", () => {
      const contact = ContactFactory.new();
      action = actions.add(contact);
      stateBefore = {
        on_edit: false,
        errors: [],
        loaded_contact: contact,
        rows: []
      };
      stateAfter = {
        on_edit: false,
        errors: [],
        loaded_contact: ContactFactory.empty(contact.id-1),
        rows: [contact]
      };
    });

    it("prevents adition of an invalid contact", () => {
      const contact = ContactFactory.empty();
      action = actions.add(contact);
      stateBefore = {
        on_edit: false,
        errors: [],
        loaded_contact: contact,
        rows: []
      };
      stateAfter = {
        on_edit: false,
        errors: [I18n.t("errors.contact.all_empty")],
        loaded_contact: contact,
        rows: []
      };
    });
  });

  it("LOAD_TO_FORM action", () => {
    it("loads contact to form", () => {
      const contact = ContactFactory.new();
      action = actions.load(contact);
      stateBefore = {
        on_edit: false,
        errors: [],
        loaded_contact: ContactFactory.empty(),
        rows: [contact]
      };
      stateAfter = {
        on_edit: true,
        errors: [],
        loaded_contact: contact,
        rows: [contact]
      };
    });
  });

  describe("UPDATE action", () => {
    it("updates contact with valid attributes", () => {
      const contact = ContactFactory.new();
      const updatedContact = ContactFactory.new(contact.id, "Jose");
      action = actions.update(updatedContact);
      stateBefore = {
        on_edit: false,
        errors: [],
        loaded_contact: contact,
        rows: [contact]
      };
      stateAfter = {
        on_edit: false,
        errors: [],
        loaded_contact: ContactFactory.empty(-6),
        rows: [updatedContact]
      };
    });

    it("prevents update of a contact with invalid attributes", () => {
      const contact = ContactFactory.new();
      action = actions.update(ContactFactory.empty(contact.id));
      stateBefore = {
        on_edit: false,
        errors: [],
        loaded_contact: contact,
        rows: [contact]
      };
      stateAfter = {
        on_edit: false,
        errors: [I18n.t("errors.contact.all_empty")],
        loaded_contact: contact,
        rows: [contact]
      };
    });
  });

  describe("CANCEL_EDITION action", () => {
    it("cleans form", () => {
      const contact = ContactFactory.new();
      action = actions.cancel_edition();
      stateBefore = {
        on_edit: true,
        errors: [],
        loaded_contact: contact,
        rows: [contact]
      };
      stateAfter = {
        on_edit: false,
        errors: [],
        loaded_contact: ContactFactory.empty(-9),
        rows: [contact]
      };
    });
  });

  describe("REMOVE action", () => {
    it("removes a contact from the list", () => {
      const contact1 = ContactFactory.new();
      const contact2 = ContactFactory.new();
      action = actions.remove(contact1);
      stateBefore = {
        on_edit: false,
        errors: [],
        loaded_contact: ContactFactory.empty(-10),
        rows: [contact1, contact2]
      };
      stateAfter = {
        on_edit: false,
        errors: [],
        loaded_contact: ContactFactory.empty(-12),
        rows: [contact2]
      };
    });

    it("cleans form if the removed contact is loaded", () => {
      const contact1 = ContactFactory.new();
      const contact2 = ContactFactory.new();
      action = actions.remove(contact1);
      stateBefore = {
        on_edit: true,
        errors: [],
        loaded_contact: contact1,
        rows: [contact1, contact2]
      };
      stateAfter = {
        on_edit: false,
        errors: [],
        loaded_contact: ContactFactory.empty(-15),
        rows: [contact2]
      };
    });
  });
});
