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

  describe("before_submit_or_leave", () => {
    describe("when dealing with donations", () => {
      it("sets form state as 'changed'", () => {
        const donation = {
          donation_date: '01/02/2013',
          value: '3',
          remark: '4',
        }

        add_donation(donation);
        before_submit_or_leave();
        expect(any_change).toEqual(true);
      });

      it("does not set form state as 'changed'", () => {
        before_submit_or_leave();
        expect(any_change).toEqual(false);
      });

      it("does not set form state as 'changed' if the correspondent function is not defined", () => {
        before_submit_or_leave();
        expect(any_change).toEqual(false);
      });
    });

    describe("when dealing with contacts", () => {
      it("sets the form state as 'changed'", () => {
        const contact = {
          id: -1,
          name: '2',
          position: '3',
          email_address: 'foo@gmail.com',
          telephone: '5',
          celphone: '6',
          fax: '7'
        }

        add_contact(contact);
        before_submit_or_leave();
        expect(any_change).toEqual(true);
      });

      it("does not set form state as 'changed'", () => {
        before_submit_or_leave();
        expect(any_change).toEqual(false);
      });
    });
  });
});