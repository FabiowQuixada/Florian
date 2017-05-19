// This file was generated through erb templating. Any changes you do directly
// in this file will be overriden when the "build_client_data:all" rake task is run;

import I18n from './i18n';
import Constants from './server_constants';

// TODO Scope on path functions;
const ServerFunctions = {
  paths: {
    send_test_receipt_email: (id) => "/receipt_emails/-1/send_test".replace("-1", id),
    resend_receipt_email: (id) => "/receipt_emails/-1/resend".replace("-1", id),
    activate: (model, id) => {
      if(model === "roles" || model === "users")
        return "/admin/users/-1/activate".replace("users", model).replace("-1", id);

      return "/receipt_emails/-1/activate".replace("receipt_emails", model).replace("-1", id);
    },
    deactivate: (model, id) => {
      if(model === "roles" || model === "users")
        return "/admin/users/-1/deactivate".replace("users", model).replace("-1", id);
      return "/receipt_emails/-1/deactivate".replace("receipt_emails", model).replace("-1", id);
    },
    index: model_name => "/receipt_emails".replace("receipt_emails", model_name),
  },

  buttons: {
    activate: (model, id) => {
      const i18nModel = I18n.t(`activerecord.models.${model}.one`);
      return `<img title="${I18n.t('model_phrases.status.is_active.n.s', {model: i18nModel})}"
        class="activate_btn status_btn"
        id="change_status_${id}"
        src=${Constants.paths.assets.deactivate}
        alt="${I18n.t('helpers.action.activate')}">`;
    },
    deactivate: (model, id) => {
      const i18nModel = I18n.t(`activerecord.models.${model}.one`);
      return `<img title="${I18n.t('model_phrases.status.is_active.n.s', {model: i18nModel})}"
        class="deactivate_btn status_btn"
        id="change_status_${id}"
        src=${Constants.paths.assets.activate}
        alt="${I18n.t('helpers.action.deactivate')}">`;
    }
    ,
  }
};

export default ServerFunctions;
