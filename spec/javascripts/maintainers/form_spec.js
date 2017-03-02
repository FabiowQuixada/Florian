describe("Maintainer form", () => {

  describe("update_fields_by_entity_type", () => {

    beforeEach(() => {
      jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures';
      loadFixtures('maintainers/form.html');
      $.holdReady(true);
    });

    it("displays person data", () => {
      $("#maintainer_entity_type").val("person");
      update_fields_by_entity_type();
      expect($('#maintainer_area')).toHaveClass('hidden');
      expect($('#person_area')).not.toHaveClass('hidden');
    });

    it("displays maintainer data", () => {
      $("#maintainer_entity_type").val("company");
      update_fields_by_entity_type();
      expect($('#maintainer_area')).not.toHaveClass('hidden');
      expect($('#person_area')).toHaveClass('hidden');
    });
  });

  describe("preprocess_data", () => {
    describe("when dealing with donations", () => {
      it("sets form state as 'changed'", () => {
        transient_donations = 1;
        preprocess_data();
        expect(any_change).toEqual(true);
      });

      it("does not set form state as 'changed'", () => {
        transient_donations = 0;
        preprocess_data();
        expect(any_change).toEqual(false);
      });

      it("does not set form state as 'changed' if the correspondent function is not defined", () => {
        preprocess_data();
        expect(any_change).toEqual(false);
      });
    });

    describe("when dealing with contacts", () => {
      it("sets the form state as 'changed'", () => {
        transient_contacts = 1;
        preprocess_data();
        expect(any_change).toEqual(true);
      });

      it("does not set form state as 'changed'", () => {
        transient_contacts = 0;
        preprocess_data();
        expect(any_change).toEqual(false);
      });
    });
  });
});