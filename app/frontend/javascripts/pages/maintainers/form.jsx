import React from 'react';
import ReactDOM from 'react-dom';
import { createStore } from 'redux'
import { Provider } from 'react-redux';
import maintainerReducer from './../../reducers/maintainerReducer';
import ContactAreaContainer from './../../containers/ContactAreaContainer'
import DonationAreaContainer from './../../containers/DonationAreaContainer'
import { on_page } from './../support/application'
import { set_number_of_tabs } from './../support/tab_commons'
import { init } from './../support/form_commons'
import { display_error } from './../support/message_area'
import { validate_email } from './../support/application'

$(() => { if(on_page('maintainers', 'form')) new MaintainersForm() });

const MaintainersForm = (function() {
  function MaintainersForm() {
    const that = this;

    this.before_submit_or_leave = () => (that.new_donations() || that.new_contacts())

    this.update_fields_by_entity_type = () => {
      $('.person_area').addClass('hidden');
      $('.maintainer_area').addClass('hidden');

      if($('#maintainer_entity_type').val() === "company") {
        $('.maintainer_area').removeClass('hidden');
      } else if($('#maintainer_entity_type').val() === "person") {
        $('.person_area').removeClass('hidden');
      }
    }

    this.new_donations = () => {
      let new_donation = false;

      $("#donations_table .server-communication-data input.donation_id").each((index, input) => {
        if(parseInt($(input).val()) < 0)
          new_donation = true;
      });

      return new_donation;
    }

    this.new_contacts = () => {
      let new_contact = false;

      $("#contacts_table td.contact_id").each((index, td) => {
        if(parseInt($(td).text()) < 0)
          new_contact = true;
      });

      return new_contact;
    }

    this.setup_listeners = () => {
      $("body").on("change", "#maintainer_entity_type",
        () => { that.update_fields_by_entity_type(); }
      );

      $("body").on("submit", "#main_form", e => {
        that.before_submit_or_leave();

        if(!that.validate(that.build_form_obj())) {
          e.preventDefault();
        }
      });
    }

    this.build_form_obj = () => ({
      email: $('#maintainer_email_address').val()
    });

    this.validate = form_obj => {
      const errors = new Array();

      if(form_obj.email && !validate_email(form_obj.email)) {
        const attribute = I18n.t('activerecord.attributes.maintainer.email_address');
        errors.push(I18n.t('errors.messages.invalid', { attribute: attribute }));
      }

      if(errors.length > 0) {
        display_error(errors);
        return false;
      }

      return true;
    }

    this.setup_view_components = () => {
      const store = createStore(maintainerReducer);

      ReactDOM.render(
        <Provider store={store}>
          <DonationAreaContainer />
        </Provider>,
        document.getElementById("donation_area")
      );

      ReactDOM.render(
        <Provider store={store}>
          <ContactAreaContainer />
        </Provider>,
        document.getElementById("main_tab_2")
      );
    }

    set_number_of_tabs('main', 3);
    init(this.before_submit_or_leave);
    this.update_fields_by_entity_type();
    this.setup_listeners();
    this.setup_view_components();
  }

  return MaintainersForm;
}());

export default MaintainersForm;
