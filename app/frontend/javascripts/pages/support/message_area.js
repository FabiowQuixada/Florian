import I18n from "./../../i18n";
import Constants from "./../../server_constants";

export const display_error = (message, error_box_id = "global") => {
  let result = "";

  if(is_empty(message)) {
    return;
  }

  if (Object.prototype.toString.call(message) === "[object Array]") {
    result = msg_as_html_ul(message);
  } else {
    result = message;
  }

  hide_all_messages();
  $(`#${error_box_id}_error_messages`).html(result);
  $(`#${error_box_id}_error_box`).removeClass("hidden");
};

export const display_info = message => {
  if(is_empty(message)) {
    return;
  }

  hide_all_messages();
  to_top();
  $("#global_info_messages").html(message);
  $("#global_info_box").removeClass("hidden");
};

export const display_notice = message => {
  if(is_empty(message)) {
    return;
  }

  hide_all_messages();
  to_top();
  $("#global_notice_messages").html(message);
  $("#global_notice_box").removeClass("hidden");
};

export const display_warning = message => {
  if(is_empty(message)) {
    return;
  }

  hide_all_messages();
  to_top();
  $("#global_warning_messages").html(message);
  $("#global_warning_box").removeClass("hidden");
};

export const display_hideless_warning = message => {
  if(is_empty(message)) {
    return;
  }

  $("#global_hideless_warning_messages").html(message);
  $("#global_hideless_warning_box").removeClass("hidden");
};

const hide_info = () => {
  $("#global_info_messages").html("");
  $("#global_info_box").addClass("hidden");
};

const hide_notice = () => {
  $("#global_notice_messages").html("");
  $("#global_notice_box").addClass("hidden");
};

export const hide_errors = () => {
  $("#global_error_messages").html("");
  $("#global_error_box").addClass("hidden");

  if($("#form_error_messages").length && $("#form_error_box").length) {
    $("#form_error_messages").html("");
    $("#form_error_box").addClass("hidden");
  }
};

export const hide_all_messages = () => {
  hide_info();
  hide_notice();
  hide_errors();
};

export const msg_as_html_ul = message => {
  if(is_empty(message)) {
    return "";
  }

  let result = "<ul>";
  let msg_array = message;

  if(typeof message === "string" || message instanceof String) {
    msg_array = [message];
  }

  for (let i = 0; i < msg_array.length; i++)
    result += `<li>${msg_array[i]}<\/li>`;

  result += "<\/ul>";

  return result;
};

export const is_empty = message => {
  if(typeof message !== "string" && Object.prototype.toString.call(message) !== "[object Array]")
    return true;

  if(message.length === 0)
    return true;

  if(Object.prototype.toString.call(message) === "[object Array]" && message[0] === "")
    return true;

  return false;
};

export const to_top = () => {
  $("html, body").animate({
    scrollTop: $("body").offset().top
  }, 1000);
};

$(() => {
  // Handles alert hide, instead of dismiss;
  $("[data-hide]").on("click", e => {
    const elem = e.target;
    $(elem).closest(`.${$(elem).attr("data-hide")}`).addClass("hidden");
  });

  if ($("#rails_env").val() === "showcase" && $("body").attr("class") === "sessions new") {
    const user_number = Constants.showcase_env.user_numbers[Math.floor(Math.random() * Constants.showcase_env.user_numbers.length)];
    const email = `${Constants.showcase_env.user}_${user_number}@florian.com`;

    display_hideless_warning(I18n.t("showcase.login_info", {
      showcase_email: email,
      showcase_password: Constants.showcase_env.password
    }));
  }
});
