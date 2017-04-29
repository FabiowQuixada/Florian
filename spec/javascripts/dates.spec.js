import * as Dates from './../../app/frontend/javascripts/dates'
import I18n from './../../app/frontend/javascripts/i18n'

describe("Date", () => {
  it("formatted as competence", () => {
    jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures';
    loadFixtures('dates.html');
    const source_field_id = "source";
    const target_field_id = "target";

    Dates.format_competence(source_field_id, target_field_id);

    expect($(`#${target_field_id}`).val()).toEqual('02-13-01');
  });

  it("is converted to rails format", () => {
    expect(Dates.to_rails_date("02/13/2014")).toEqual("2014-02-13");
    expect(() => Dates.to_rails_date("13/02/2014")).toThrow(Dates.date_exc_msg());
    expect(() => Dates.to_rails_date("02/32/2014")).toThrow(Dates.date_exc_msg());
    expect(() => Dates.to_rails_date("02/32014")).toThrow(Dates.date_exc_msg());
    expect(() => Dates.to_rails_date("some text")).toThrow(Dates.date_exc_msg());
  });

  it("is converted to js format", () => {
    expect(Dates.to_js_date("2014-02-13")).toEqual(new Date(2014, 1, 13, 0, 0, 0, 0));
    expect(() => Dates.to_js_date("2016/02-13")).toThrow(Dates.date_exc_msg());
    expect(() => Dates.to_js_date("20-02-13")).toThrow(Dates.date_exc_msg());
    expect(() => Dates.to_js_date("some text")).toThrow(Dates.date_exc_msg());
  });

  it("is compared in rails format", () => {
    expect(Dates.is_after("2014-02-13", "2015-02-13")).toBe(false);
    expect(Dates.is_after("2016-02-13", "2015-02-13")).toBe(true);
  });

  it("is validated in rails format", () => {
    expect(Dates.validate_period("2016-02-13", "2015-02-13", "Nope")).toEqual(["Nope"]);
    expect(Dates.validate_period("2016-02-13", "2015-02-13", "Yeap")).toEqual(["Yeap"]);
    expect(Dates.validate_period("2016-02-13", "2015-02-13")).toEqual([I18n.t('errors.messages.invalid_period_i')]);
    expect(Dates.validate_period("2014-02-13", "2015-02-13")).toEqual([]);
  });

  it("is valid", () => {
    expect(Dates.is_valid_date("02/13/2014")).toBe(true);
    expect(Dates.is_valid_date("13/02/2014")).toBe(false);
    expect(Dates.is_valid_date("10/32/2014")).toBe(false);
  });

  it("is valid in rails format", () => {
    expect(Dates.is_valid_rails_date("2014-01-01")).toBe(true);
    expect(Dates.is_valid_rails_date("2014-13-01")).toBe(false);
    expect(Dates.is_valid_rails_date("2014-10-32")).toBe(false);
    expect(Dates.is_valid_rails_date("01/01/2014")).toBe(false);
  });
});
