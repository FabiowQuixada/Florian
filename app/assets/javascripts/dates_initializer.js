// This piece of code is separated because it will be ignored by Karma. 
// If this code runs during Karma tests, it raises a few errors;

$(() => {
  set_month_datepicker();
  set_datepicker();
  $(".datepicker-switch").html(I18n.t('datetime.prompts.month.other'));
});