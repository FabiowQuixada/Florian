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
//= require_tree .

var display_admin_data = false;

function toogle_admin_data() {		

	if(display_admin_data) {
		$('.admin-only').show();
	} else {
		$('.admin-only').hide();
	}

	display_admin_data = !display_admin_data;
}

function to_top() {
	$('html, body').animate({
		scrollTop: $("body").offset().top
	}, 1000);
}

var entity_map = {
	"&": "&amp;",
	"<": "&lt;",
	">": "&gt;",
	'"': '&quot;',
	"'": '&#39;',
	"/": '/' // &#x2F;
};

function number_to_currency(number) {
	return number.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
}

// The input should be a set of inputs, eg, '#summable-inputs input';
function currency_sum(elements) {
	sum = 0;
	$(elements).each(function() {
		sum += parseFloat( $(this).val().replace( /,/g, '')*100 );
	});

	return number_to_currency(sum/100);
}

function escape_html(string) {
	return String(string).replace(/[&<>"'\/]/g, function (s) {
		return entity_map[s];
	});
}

$(function() {
	toogle_admin_data();
})