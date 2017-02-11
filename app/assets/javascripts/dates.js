function set_month_datepicker() {
	$('.datepicker-competence').datepicker()
	$('[data-behaviour~=datepickercompetence]').datepicker({
		minViewMode: 1,
		format: I18n.t("date.formats.javascript_format.competence"),
		autoclose: true,
		language: I18n.locale
	});
}

function set_datepicker() {

	$('.datepicker').datepicker()
	$('[data-behaviour~=datepicker]').datepicker({
		format: I18n.t("date.formats.javascript_format.date"),
		autoclose: true,
		language: I18n.locale,
		daysOfWeekDisabled: [0,6],
		setDate: new Date()
	});
}

function current_competence() {
	var today = new Date();
	var mm = today.getMonth() + 1; //January is 0!
	var yyyy = today.getFullYear();

	if(mm < 10) {
		mm = '0' + mm;
	}

	return mm + '/' + yyyy;
}


// source field input format: mm/yyyy;
function format_competence(source_field, target_field) {
	var temp = $('#' + source_field).val().split("/");
	year = temp[1];
	month = temp[0];

	$('#' + target_field).val(year + '-' + month + '-01');
}

// Input format: mm/dd/yyyy;
function to_rails_date(date_string) {

	if(!is_valid_date(date_string))
	  return null;

	var temp = date_string.split("/");

	var date = new Date(temp[2], temp[0] - 1, temp[1]);
	year = date.getFullYear();
	month = ('0' + (date.getMonth() + 1)).slice(-2);
	day = ('0' + date.getDate()).slice(-2);

	return year + '-' + month + '-' + day;
}

// Format: yyyy-mm-dd;
function to_js_date(rails_date) {
  var temp = rails_date.split("-");
  return new Date(temp[0], temp[1]-1, temp[2], 0, 0, 0, 0);
}

// Format: yyyy-mm-dd;
function is_after(start_date, end_date) {
  return to_js_date(start_date) > to_js_date(end_date);
}

// Format: yyyy-mm-dd;
function validate_period(start_date, end_date, msg) {

	if (typeof(msg) === 'undefined') 
	  msg = I18n.t('errors.messages.invalid_period_i');

	if(!start_date || !end_date) {
		return new Array();
	}

	var errors = new Array();

	if(is_after(start_date, end_date)) {
		errors.push(msg);
	}

	return errors;
}

// Input format: mm/dd/yyyy;
function is_valid_date(date_string) {
	var comp = date_string.split('/');
	var m = parseInt(comp[0], 10);
	var d = parseInt(comp[1], 10);
	var y = parseInt(comp[2], 10);
	var date = new Date(y,m-1,d);

	if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
	  return true;
	} else {
	  return false;
	}
}

$(function() {

	set_month_datepicker();
	set_datepicker();

	$(".datepicker-switch").html(I18n.t('datetime.prompts.month.other'));

});