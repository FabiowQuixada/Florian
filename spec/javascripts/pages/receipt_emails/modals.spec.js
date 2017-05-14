import ReceiptEmailsModals from "./../../../../app/frontend/javascripts/pages/receipt_emails/modals";
import ReceiptEmailFactory from "./../../../../app/frontend/javascripts/factories/ReceiptEmailFactory";
import ReceiptEmailHistoryFactory from "./../../../../app/frontend/javascripts/factories/ReceiptEmailHistoryFactory";

describe("Receipt E-mail Modal", () => {
  let receipt_modal;

  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = "base/spec/javascripts/fixtures";
    receipt_modal = new ReceiptEmailsModals();
    loadFixtures("receipt_emails/modals.html");
    $.holdReady(true);
  });

  describe("add_history_item", () => {
    let email;

    beforeEach(() => {
      email = ReceiptEmailFactory.new();
      receipt_modal.add_history_item(email);
    });

    it("displays e-mail date", () => {
      expect($("#history_table > tbody tr:last-child").html()).toContainText(email.date);
    });

    it("displays e-mail value", () => {
      expect($("#history_table > tbody tr:last-child").html()).toContainText(email.value);
    });

    it("displays e-mail type", () => {
      expect($("#history_table > tbody tr:last-child").html()).toContainText(email.type);
    });

    it("displays e-mail user", () => {
      expect($("#history_table > tbody tr:last-child").html()).toContainText(email.user);
    });
  });

  describe("add_recent_email", () => {
    let email_history;

    beforeEach(() => {
      email_history = ReceiptEmailHistoryFactory.new();
      receipt_modal.add_recent_email(email_history);
    });

    it("displays e-mail date", () => {
      expect($("#recent_emails_table > tbody tr:last-child").html()).toContainText(email_history.date);
    });

    it("displays e-mail maintainer", () => {
      expect($("#recent_emails_table > tbody tr:last-child").html()).toContainText(email_history.maintainer);
    });

    it("displays e-mail type", () => {
      expect($("#recent_emails_table > tbody tr:last-child").html()).toContainText(email_history.type);
    });
  });

  describe("build_email", () => {
    beforeEach(() => {
      $("#receipt_email_id").val("4");
      $("#receipt_email_recipients_array").val("example@google.com");
      $("#receipt_email_maintainer").val("Jasmine Inc.");
      $("#receipt_email_value").val("45.00");
      $("#receipt_email_title").val("receipt title");
      $("#receipt_email_body").val("receipt body");
      $("#model_status").val("active");
    });

    it("builds an e-mail object based on inputs", () => {
      expect(receipt_modal.build_email()).toEqual({
        id: "4",
        recipients_array: "example@google.com",
        value: "45.00",
        maintainer: "Jasmine Inc.",
        title: "receipt title",
        body: "receipt body",
        active: "active"
      });
    });
  });

  describe("setup_listeners", () => {
    it("binds modal confirmation button to form submit", () => {
      // const submit = jasmine.createSpy();
      // spyOn(document 'getElementById').andReturn({submit:submit})

      // submitform('[somedata]');
      // expect(submit).toHaveBeenCalled();


      // const submitCallback = jasmine.createSpy('main_form').and.returnValue(true);
      // $('form').submit(submitCallback);
      // $("#modal_save_btn").trigger('click');
      // expect(submitCallback).toHaveBeenCalled();


      // spyOn(maintainers_form, 'before_submit_or_leave');
      // $("#main_form").trigger('submit');
      // expect(maintainers_form.before_submit_or_leave).toHaveBeenCalled();
    });

    // TODO Karma does not load Bootstrap;
    // it("binds 'resend e-mail' modal confirmation button to request", () => {
    //   spyOn(receipt_modal, 'send_request');
    //   $("#resend_email_modal .btn-ok").first().trigger('click');
    //   expect(receipt_modal.send_request).toHaveBeenCalled();
    // });

    // TODO Karma does not load Bootstrap;
    // it("binds 'send test e-mail' modal confirmation button to request", () => {
    //   spyOn(receipt_modal, 'send_request');
    //   $("#send_test_email_modal .btn-ok").first().trigger('click');
    //   expect(receipt_modal.send_request).toHaveBeenCalled();
    // });
  });
});
