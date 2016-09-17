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
//= require jquery-tablesorter
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

function display_confirm_modal(title, message, confirm_callback, cancel_callback) {
	$("#confirm_modal .modal-title").html(title);
	$("#confirm_modal .modal-body").html(message);
	$("#confirm_btn").on("click", confirm_callback);
	
	if(cancel_callback !== 'undefined')
		$("#cancel_btn").on("click", cancel_callback);
	
	$("#confirm_modal").modal("show");
}

function to_top() {
	$('html, body').animate({
		scrollTop: $("body").offset().top
	}, 1000);
}

var entityMap = {
	"&": "&amp;",
	"<": "&lt;",
	">": "&gt;",
	'"': '&quot;',
	"'": '&#39;',
	"/": '/' // &#x2F;
};

function escape_html(string) {
	return String(string).replace(/[&<>"'\/]/g, function (s) {
		return entityMap[s];
	});
}

$(function() {
	toogle_admin_data();
})