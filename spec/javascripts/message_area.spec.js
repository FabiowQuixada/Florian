import * as message_area from './../../app/frontend/javascripts/message_area'

describe("Message area", () => {
  let index_commons;

  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures';
    loadFixtures('message_area.html');
    $.holdReady(true);
  });

  describe("display_error", () => {
    describe("string", () => {
      it("displays error box", () => {
        message_area.display_error("some message");
        expect($('#global_error_messages').text()).toEqual("some message");
        expect($('#global_error_box').hasClass('hidden')).toEqual(false);
      });

      it("does not display error box when an empty string is given", () => {
        message_area.display_error("");
        expect($('#global_error_box').hasClass('hidden')).toEqual(true);
      });
    });

    describe("array", () => {
      it("displays array error", () => {
        message_area.display_error(["some message"]);
        expect($('#global_error_messages').text()).toEqual("some message");
        expect($('#global_error_box').hasClass('hidden')).toEqual(false);
      });

      it("does not display array error when an empty array is given", () => {
        message_area.display_error([]);
        expect($('#global_error_box').hasClass('hidden')).toEqual(true);
      });

      it("does not display array error when an array with an empty stringis given", () => {
        message_area.display_error([""]);
        expect($('#global_error_box').hasClass('hidden')).toEqual(true);
      });
    });
  });

  describe("display_info", () => {
    it("displays info box", () => {
      message_area.display_info("some message");
      expect($('#global_info_messages').text()).toEqual("some message");
      expect($('#global_info_box').hasClass('hidden')).toEqual(false);
    });

    it("does not display info box when an empty string is given", () => {
      message_area.display_info("");
      expect($('#global_info_box').hasClass('hidden')).toEqual(true);
    });
  });

  describe("display_notice", () => {
    it("displays notice box", () => {
      message_area.display_notice("some message");
      expect($('#global_notice_messages').text()).toEqual("some message");
      expect($('#global_notice_box').hasClass('hidden')).toEqual(false);
    });

    it("does not display notice box when an empty string is given", () => {
      message_area.display_notice("");
      expect($('#global_notice_box').hasClass('hidden')).toEqual(true);
    });
  });

  describe("display_warning", () => {
    it("displays warning box", () => {
      message_area.display_warning("some message");
      expect($('#global_warning_messages').text()).toEqual("some message");
      expect($('#global_warning_box').hasClass('hidden')).toEqual(false);
    });

    it("does not display warning box when an empty string is given", () => {
      message_area.display_warning("");
      expect($('#global_warning_box').hasClass('hidden')).toEqual(true);
    });
  });

  describe("display_hideless_warning", () => {
    it("displays unhideable warning box", () => {
      message_area.display_hideless_warning("some message");
      expect($('#global_hideless_warning_messages').text()).toEqual("some message");
      expect($('#global_hideless_warning_box').hasClass('hidden')).toEqual(false);
    });

    it("does not display unhideable warning box when an empty string is given", () => {
      message_area.display_hideless_warning("");
      expect($('#global_hideless_warning_box').hasClass('hidden')).toEqual(true);
    });
  });

  describe("hide_all_messages", () => {
    beforeEach(() => {
      message_area.hide_all_messages();
    });

    it("empties info box text", () => {
      expect($('#global_info_messages').text()).toEqual('');
    });

    it("hides info box", () => {
      expect($('#global_info_box').hasClass('hidden')).toEqual(true);
    });

    it("empties notice box text", () => {
      expect($('#global_notice_messages').text()).toEqual('');
    });

    it("hides notice box", () => {
      expect($('#global_notice_box').hasClass('hidden')).toEqual(true);
    });

    it("empties error box text", () => {
      expect($('#global_error_messages').text()).toEqual('');
    });

    it("hides error box", () => {
      expect($('#global_error_box').hasClass('hidden')).toEqual(true);
    });
  });

  describe("msg_as_html_ul", () => {
    it("transformas array", () => {
      expect(message_area.msg_as_html_ul(["msg1", "msg2"])).toEqual("<ul><li>msg1</li><li>msg2</li></ul>");
    });

    it("transforms string", () => {
      expect(message_area.msg_as_html_ul("msg1")).toEqual("<ul><li>msg1</li></ul>");
    });

    it("does not transform empty string", () => {
      expect(message_area.msg_as_html_ul("")).toEqual("");
    });

    it("does not transform array with an empty string", () => {
      expect(message_area.msg_as_html_ul([""])).toEqual("");
    });
  });

  describe("is_empty", () => {
    describe("string", () => {
      it("empty", () => {
        expect(message_area.is_empty("")).toEqual(true);
      });

      it("non-empty", () => {
        expect(message_area.is_empty("some message")).toEqual(false);
      });
    });

    describe("array", () => {
      it("empty", () => {
        expect(message_area.is_empty([])).toEqual(true);
      });

      it("with a text", () => {
        expect(message_area.is_empty(["some message"])).toEqual(false);
      });

      it("with an empty string", () => {
        expect(message_area.is_empty([""])).toEqual(true);
      });
    });

    describe("other types", () => {
      it("number", () => {
        expect(message_area.is_empty(5)).toEqual(true);
      });

      it("object", () => {
        expect(message_area.is_empty({})).toEqual(true);
      });
    });
  });

  describe("parse_json_errors", () => {
    // TODO
  });
});
