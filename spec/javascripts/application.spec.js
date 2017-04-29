import * as application from './../../app/frontend/javascripts/application'

describe("application", () => {
  beforeEach(() => {
    jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures';
    loadFixtures('application.html');
  });

  describe("admin data", () => {

    it("displays admin data", () => {
      $('.admin-only').show();
      application.toogle_admin_data();
      expect(application.displaying_admin_data()).toEqual(true);
      expect($('.admin-only')[0]).toBeHidden();
    });

    it("hides admin data", () => {
      $('.admin-only').hide();
      application.toogle_admin_data();
      expect(application.displaying_admin_data()).toEqual(false);
      expect($('.admin-only')[0]).not.toBeHidden();
    });
  });
  
  it("converts numbers to currency", () => {
    // TODO Locale is not loaded with Karma;
    // expect(application.to_money(34.78)).toEqual('34.78');
    // expect(application.to_money(5234.78)).toEqual('5,234.78');
    // expect(application.to_money(154779)).toEqual('154,779.00');
    // expect(application.to_money(0)).toEqual('0.00');
  });

  it("sums elements by css class", () => {
    // TODO Locale is not loaded with Karma;
    // expect(application.currency_sum('#summable-inputs input')).toEqual('23,475.04');
  });

  it("escapes html", () => {
    expect(application.escape_html("&<>\"'/")).toEqual('&amp;&lt;&gt;&quot;&#39;/');
  });
});
