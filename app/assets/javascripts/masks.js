$(function() {

	var celphone_mask_behavior = function (val) {
		return val.replace(/\D/g, '').length === 11 ? '(00) 0 0000-0000' : '(00) 0000-00009';
	},
	celphone_mask_options = {
		onKeyPress: function(val, e, field, options) {
			field.mask(celphone_mask_behavior.apply({}, arguments), options);
		},
		placeholder : "(__) _ ____-____"
	};

	$(".cnpj").mask("99.999.999/9999-99", { placeholder : "__.___.___/____-__" });
	$(".cpf").mask("999.999.999-99", { placeholder : "___.___.___-__" });
	$(".cep").mask("99.999-999", { placeholder : "_____-___" });
	$('.celphone').mask(celphone_mask_behavior, celphone_mask_options);
    $(".telephone").mask("(99) 9999-9999", { placeholder : "(__) ____-____"	});
	$(".fax").mask("(99) 9999-9999", { placeholder : "(__) ____-____" });
	$('.day_of_month').mask('99');
	$('.numbers_only').mask('9999999');
	$('.money').mask('000.000.000,00', { reverse : true });

	// Field initialization;
	$(".money").each(function() {
		if(!$(this).val() || $(this).val() == '0.0')
			$(this).val('0,00');
	});

	$('.numbers_only').each(function() {
		if(!$(this).val())
			$(this).val('0');
	});
});