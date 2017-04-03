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

/* 

  On top of some javascript files, there will be the a line like the following:
    $(() => { if(on_page('bills', 'edit')) bills_edit(); });
  
  on_page('bills', 'edit') means if the rendered page was a result of the 'edit' action in the BillsController.

  ...which means: "When the document is ready, if the user is on_page(), call the 'bills_edit' function,
  which is defined below."


  This is necessary so the function is available both for:
   - Sprockets in the asset pipeline;
   - Jasmine / Karma tests;

*/

import I18n from './i18n.js'

export const on_page = (controller, action) => on_controller(controller) && on_action(action)

export const on_controller = controller => {
  if($("body").hasClass(controller))
    return true;

  return false;
}

export const on_action = action => {
  if(action === 'new')
    return $("body").hasClass('new') || $("body").hasClass('create');

  if(action === 'edit')
    return $("body").hasClass('edit') || $("body").hasClass('update');

  if(action === 'form')
    return $("body").hasClass('new') || $("body").hasClass('create') || $("body").hasClass('edit') || $("body").hasClass('update');

  return $("body").hasClass(action);
}

export const validate_email = email => (
  /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
      .test(email)
  )

let display_admin_data = false;

export const toogle_admin_data = () => {   
  if(display_admin_data) {
    $('.admin-only').show();
  } else {
    $('.admin-only').hide();
  }

  display_admin_data = !display_admin_data;
}

export const to_money = number => {
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
export const currency_sum = elements => {
  let sum = 0;
  $(elements).each((i, field) => {
    sum += parseFloat( $(field).val().replace(/,/g, '') * 100 );
  });

  return to_money(sum / 100);
}

export const escape_html = string => {
  const entity_map = {
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': '&quot;',
    "'": '&#39;',
    "/": '/' // &#x2F;
  };

  return String(string).replace(/[&<>"'\/]/g, s => entity_map[s]);
}

$(() => {
  toogle_admin_data();
})
