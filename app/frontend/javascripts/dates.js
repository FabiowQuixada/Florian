import I18n from './i18n';

require('bootstrap-datepicker');

export const set_month_datepicker = () => {
  $('.datepicker-competence').datepicker();
  $('[data-behaviour~=datepickercompetence]').datepicker({
    minViewMode: 1,
    format: I18n.t("date.formats.javascript_format.competence"),
    autoclose: true,
    language: I18n.locale
  });
};

export const set_datepicker = () => {
  $('.datepicker').datepicker();
  $('[data-behaviour~=datepicker]').datepicker({
    format: I18n.t("date.formats.javascript_format.date"),
    autoclose: true,
    language: I18n.locale,
    daysOfWeekDisabled: [0,6],
    setDate: new Date()
  });
};

export const date_exc_msg = () => {
  const attribute = "Date";
  return I18n.t("errors.messages.invalid", {attribute});
};

export const current_competence = () => {
  const today = new Date();
  const yyyy = today.getFullYear();
  let mm = today.getMonth() + 1; //January is 0!

  if(mm < 10) {
    mm = `0${mm}`;
  }

  return `${mm}/${yyyy}`;
};


// source field input format: mm/yyyy;
export const format_competence = (source_field, target_field) => {
  if(!$(`#${source_field}`).val()) {
    return $(`#${target_field}`).val("");
  }

  const temp = $(`#${source_field}`).val().split("/");
  const year = temp[1];
  const month = temp[0];

  $(`#${target_field}`).val(`${year}-${month}-01`);
};

// Input format: mm/dd/yyyy;
export const to_rails_date = date_string => {

  if(!date_string) {
    return null;
  }

  if(!is_valid_date(date_string)) {
    throw date_exc_msg();
  }

  const temp = date_string.split("/");

  const date = new Date(temp[2], temp[0] - 1, temp[1]);
  const year = date.getFullYear();
  const month = ('0' + (date.getMonth() + 1)).slice(-2);
  const day = ('0' + date.getDate()).slice(-2);

  return `${year}-${month}-${day}`;
};

// Format: yyyy-mm-dd;
export const to_js_date = rails_date => {
  const date_format = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
  if(!date_format.exec(rails_date)) {
    throw date_exc_msg();
  }

  const temp = rails_date.split("-");
  return new Date(temp[0], temp[1]-1, temp[2], 0, 0, 0, 0);
};

export const is_valid_rails_date = rails_date => {
  const comp = rails_date.split('-');
  const y = parseInt(comp[0], 10);
  const m = parseInt(comp[1], 10);
  const d = parseInt(comp[2], 10);
  const date = new Date(y,m-1,d);

  return date.getFullYear() === y && date.getMonth() + 1 === m && date.getDate() === d;
};

// Format: yyyy-mm-dd;
export const is_after = (start_date, end_date) => (
  is_valid_rails_date(start_date) && is_valid_rails_date(end_date) &&
  to_js_date(start_date) > to_js_date(end_date)
);

// Format: yyyy-mm-dd;
export const validate_period = (start_date, end_date, msg = I18n.t('errors.messages.invalid_period_i')) => {
  if(!start_date || !end_date) {
    return new Array();
  }

  const errors = new Array();

  if(is_after(start_date, end_date)) {
    errors.push(msg);
  }

  return errors;
};

// Input format: mm/dd/yyyy;
export const is_valid_date = date_string => {
  const comp = date_string.split('/');
  const m = parseInt(comp[0], 10);
  const d = parseInt(comp[1], 10);
  const y = parseInt(comp[2], 10);
  const date = new Date(y,m-1,d);

  return date.getFullYear() === y && date.getMonth() + 1 === m && date.getDate() === d;
};
