import donations from "./../../../app/frontend/javascripts/redux/reducers/donationsReducer";
import * as actions from "./../../../app/frontend/javascripts/redux/actions/donationsActionCreators";
import DonationFactory from "./../../../app/frontend/javascripts/factories/DonationFactory";
import I18n from "./../../../app/frontend/javascripts/i18n";

const deepFreeze = require("deep-freeze");

describe("Donations reducer", () => {
  let action;
  let stateBefore;
  let stateAfter;

  afterEach(() => {
    deepFreeze(stateBefore);
    deepFreeze(action);
    expect(donations(stateBefore, action)).toEqual(stateAfter);
  });

  describe("ADD action", () => {
    it("adds a valid donation", () => {
      const donation = DonationFactory.new();
      action = actions.add(donation);
      stateBefore = {
        errors: [],
        loaded_donation: donation,
        rows: []
      };
      stateAfter = {
        errors: [],
        loaded_donation: DonationFactory.empty(donation.id-1),
        rows: [donation]
      };
    });

    it("prevents adition of an invalid donation", () => {
      const donation = DonationFactory.dateless();
      action = actions.add(donation);
      const attribute = I18n.t("activerecord.attributes.donation.date");
      const msg = I18n.t("errors.messages.blank", { attribute });
      stateBefore = {
        errors: [],
        loaded_donation: donation,
        rows: []
      };
      stateAfter = {
        errors: [msg],
        loaded_donation: donation,
        rows: []
      };
    });
  });

  describe("REMOVE action", () => {
    it("removes a donation from the list", () => {
      const donation1 = DonationFactory.new();
      const donation2 = DonationFactory.new();
      action = actions.remove(donation1);
      stateBefore = {
        errors: [],
        loaded_donation: DonationFactory.empty(-10),
        rows: [donation1, donation2]
      };
      stateAfter = {
        errors: [],
        loaded_donation: DonationFactory.empty(-10),
        rows: [donation2]
      };
    });
  });
});
