import { init, add_tag_to_field } from './../../app/frontend/javascripts/form_commons'

describe("Form commons", () => {

  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures';
    loadFixtures('form_commons.html');
    $.holdReady(true);
  });

  describe("add_tag_to_field", () => {
    it("", () => {
      $('#some_field').val('some text');
      add_tag_to_field('some_field', '#a_tag');
      expect($('#some_field').val()).toEqual('some text #a_tag ');
    });
  });
});
