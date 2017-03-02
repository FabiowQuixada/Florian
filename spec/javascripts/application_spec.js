describe("Application", () => {
  describe("admin data", () => {
    beforeEach(() => {
      jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures';
      loadFixtures('admin_data.html');
    });

    it("displays admin data", () => {
      toogle_admin_data();
      expect(display_admin_data).toEqual(true);
      expect($('.admin-only')[0]).toBeHidden();
    });

    it("hides admin data", () => {
      toogle_admin_data();
      expect(display_admin_data).toEqual(false);
      expect($('.admin-only')[0]).not.toBeHidden();
    });
  });
  
  it("converts numbers to currency", () => {
    expect(to_money(34.78)).toEqual('34.78');
    expect(to_money(5234.78)).toEqual('5,234.78');
    expect(to_money(154779)).toEqual('154,779.00');
    expect(to_money(0)).toEqual('0.00');
  });

  it("sums elements by css class", () => {
    jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures';
    loadFixtures('summable_inputs.html');

    expect(currency_sum('#summable-inputs input')).toEqual('23,475.04');
  });

  it("escapes html", () => {
    expect(escape_html("&<>\"'/")).toEqual('&amp;&lt;&gt;&quot;&#39;/');
  });
});