function display_about_modal() {
	$("#app_about_modal").modal("show");
}

$(function() {

	$('.admin_key_btn').on('click', toogle_admin_data);
	$('#app_about_btn').on('click', display_about_modal);
	$('.numbers_only').on('blur', function() {
		if(!$(this).val())
			$(this).val('0');
	});

	// Handles alert hide, instead of dismiss;
	$("[data-hide]").on("click", function() {
		$(this).closest("." + $(this).attr("data-hide")).hide();

	});
});