describe("Date", () => {
  it("formatted as competence", () => {
    jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures';
    loadFixtures('competence.html');
    const source_field_id = "source";
    const target_field_id = "target";

    format_competence(source_field_id, target_field_id);

    expect($(`#${target_field_id}`).val()).toEqual('02-13-01');
  });

  it("is converted to rails format", () => {
    expect(to_rails_date("02/13/2014")).toEqual("2014-02-13");
    expect(to_rails_date("13/02/2014")).toBe(null);
    expect(to_rails_date("02/32/2014")).toBe(null);
  });

  it("is converted to js format", () => {
    expect(to_js_date("2014-02-13")).toEqual(new Date(2014, 1, 13, 0, 0, 0, 0));
  });

  it("is compared in rails format", () => {
    expect(is_after("2014-02-13", "2015-02-13")).toBe(false);
    expect(is_after("2016-02-13", "2015-02-13")).toBe(true);
  });

  it("is validated in rails format", () => {
    expect(validate_period("2016-02-13", "2015-02-13", "Nope")).toEqual(["Nope"]);
    expect(validate_period("2016-02-13", "2015-02-13", "Yeap")).toEqual(["Yeap"]);
    expect(validate_period("2016-02-13", "2015-02-13")).toEqual([I18n.t('errors.messages.invalid_period_i')]);
    expect(validate_period("2014-02-13", "2015-02-13")).toEqual([]);
  });

  it("is valid", () => {
    expect(is_valid_date("02/13/2014")).toBe(true);
    expect(is_valid_date("13/02/2014")).toBe(false);
    expect(is_valid_date("10/32/2014")).toBe(false);
  });
});