import * as email_address_table from './../../../../app/frontend/javascripts/others/email_address_table'
import { add_email_to_table } from './../support/emails'

describe("E-mail address table", () => {
  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures';
    loadFixtures('others/email_address_table.html');
    $.holdReady(true);
  });

  describe("new_recipients", () => {
    describe("some_field", () => {
      it("has no new recipients", () => {
        expect(email_address_table.new_recipients('some_field')).toEqual(false);
      });

      describe("recipient adition", () => {
        beforeEach(() => {
          add_email_to_table("some_field", "example@gmail.com");
        });

        it("adds e-mail to correspondent table", () => {
          expect(email_address_table.new_recipients('some_field')).toEqual(true);
        });

        it("does not add e-mail to other tables", () => {
          expect(email_address_table.new_recipients('another_field')).not.toEqual(true);
        });
      });
    });

    describe("another_field", () => {
      it("has no new recipients", () => {
        expect(email_address_table.new_recipients('another_field')).toEqual(false);
      });

      describe("recipient adition", () => {
        beforeEach(() => {
          add_email_to_table("another_field", "example@gmail.com");
        });

        it("adds e-mail to correspondent table", () => {
          expect(email_address_table.new_recipients('another_field')).toEqual(true);
        });

        it("does not add e-mail to other tables", () => {
          expect(email_address_table.new_recipients('some_field')).not.toEqual(true);
        });
      });
    });
  });

  describe("formated_recipients", () => {
    it("formats recipients", () => {
      const expected = "example_1@gmail.com, example_2@gmail.com";
      add_email_to_table("some_field", "example_1@gmail.com");
      add_email_to_table("some_field", "example_2@gmail.com");
      expect(email_address_table.formated_recipients('some_field')).toEqual(expected);
    });

    it("formats recipients", () => {
      const expected = "example_1@gmail.com, example_2@gmail.com"
      add_email_to_table("another_field", "example_1@gmail.com");
      add_email_to_table("another_field", "example_2@gmail.com");
      expect(email_address_table.formated_recipients('another_field')).toEqual(expected);
    });
  });

  describe("setup_listeners_for_email_field", () => {
    // TODO
  });
});
