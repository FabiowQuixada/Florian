import * as email_address_table from "./../../../../app/frontend/javascripts/pages/support/email_address_table";
import { add_email_to_table } from "./../support/emails";

describe("E-mail address table", () => {
  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = "base/spec/javascripts/fixtures";
    loadFixtures("others/email_address_table.html");
    $.holdReady(true);
  });

  describe("new_recipients", () => {
    describe("some_field", () => {
      it("has no new recipients", () => {
        expect(email_address_table.new_recipients("some_field")).toBe(false);
      });

      describe("recipient adition", () => {
        beforeEach(() => {
          add_email_to_table("some_field", "example@gmail.com");
        });

        it("adds e-mail to correspondent table", () => {
          expect(email_address_table.new_recipients("some_field")).toBe(true);
        });

        it("does not add e-mail to other tables", () => {
          expect(email_address_table.new_recipients("another_field")).not.toBe(true);
        });
      });
    });

    describe("another_field", () => {
      it("has no new recipients", () => {
        expect(email_address_table.new_recipients("another_field")).toBe(false);
      });

      describe("recipient adition", () => {
        beforeEach(() => {
          add_email_to_table("another_field", "example@gmail.com");
        });

        it("adds e-mail to correspondent table", () => {
          expect(email_address_table.new_recipients("another_field")).toBe(true);
        });

        it("does not add e-mail to other tables", () => {
          expect(email_address_table.new_recipients("some_field")).not.toBe(true);
        });
      });
    });
  });

  describe("formated_recipients", () => {
    it("formats recipients", () => {
      const expected = "persisted_email@google.com, example_1@gmail.com, example_2@gmail.com";
      add_email_to_table("some_field", "example_1@gmail.com");
      add_email_to_table("some_field", "example_2@gmail.com");
      expect(email_address_table.formated_recipients("some_field")).toEqual(expected);
    });

    it("formats recipients", () => {
      const expected = "example_1@gmail.com, example_2@gmail.com";
      add_email_to_table("another_field", "example_1@gmail.com");
      add_email_to_table("another_field", "example_2@gmail.com");
      expect(email_address_table.formated_recipients("another_field")).toEqual(expected);
    });
  });

  describe("setup_listeners", () => {
    it("removes e-mail", () => {
      add_email_to_table("some_field", "new_email@google.com");
      email_address_table.setup_listeners("some_field");
      $(".some_field_email_recipient .remove_btn").last().trigger("click");

      setTimeout( () => {
        expect($("#some_field_recipients_table tbody").html()).not.toContainText("new_email@google.com");
      }, 2000);
    });
  });
});
