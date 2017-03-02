// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery2
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require twitter/bootstrap
//= require bootstrap-datepicker
//= require jquery.turbolinks
//= require i18n
//= require i18n.js
//= require i18n/translations
//= require_tree .

let display_admin_data = false;
const entity_map = {
	"&": "&amp;",
	"<": "&lt;",
	">": "&gt;",
	'"': '&quot;',
	"'": '&#39;',
	"/": '/' // &#x2F;
};

const toogle_admin_data = () => {		
	if(display_admin_data) {
		$('.admin-only').show();
	} else {
		$('.admin-only').hide();
	}

	display_admin_data = !display_admin_data;
}

const to_top = () => {
	$('html, body').animate({
		scrollTop: $("body").offset().top
	}, 1000);
}

const to_money = number => {
  const cents = I18n.t("number.currency.format.precision"),
    d = I18n.t("number.currency.format.separator"),
    t = I18n.t("number.currency.format.delimiter"),
    sign = number < 0 ? "-" : "",
    i = String(parseInt(number = Math.abs(Number(number) || 0).toFixed(cents))),
    j = i.length > 3 ? i.length % 3 : 0;

  return (
    sign +
    (j ? i.substr(0, j) + t : "") +
    i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) +
    (cents ? d + Math.abs(number - i).toFixed(cents).slice(2) : "")
  );
};

// The input should be a set of inputs, eg, '#summable-inputs input';
const currency_sum = elements => {
  let sum = 0;
  $(elements).each((i, field) => {
    sum += parseFloat( $(field).val().replace(/,/g, '') * 100 );
  });

  return to_money(sum / 100);
}

const escape_html = string => String(string).replace(/[&<>"'\/]/g, s => entity_map[s])

$(() => {
  toogle_admin_data();
})