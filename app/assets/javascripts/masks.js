$(() => {

    const delimiter = I18n.t("number.currency.format.delimiter")
    const separator = I18n.t("number.currency.format.separator")

	const celphone_mask_behavior = val => {
		return val.replace(/\D/g, '').length === 11 ? '(00) 0 0000-0000' : '(00) 0000-00009';
	}
	const celphone_mask_options = {
		onKeyPress: (val, e, field, options) => {
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
	$('.money').mask(`000${delimiter}000${separator}00`, { reverse : true });	

	// Field initialization;
	$(".money").each((index, field) => {
		if(!$(field).val() || $(field).val() == '0.0' || $(field).val() == '00' || $(field).val() == '0')
			$(field).val(to_money(0));
	});

	$('.numbers_only').each((index, field) => {
		if(!$(field).val())
			$(field).val('0');
	});
});
