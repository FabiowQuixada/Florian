const display_confirm_modal = (title, message, confirm_callback, cancel_callback) => {
  $("#confirm_modal .modal-footer").removeClass('hidden');
  $("#cancel_btn").removeClass('hidden');

  $("#confirm_modal .modal-title").html(title);
  $("#confirm_modal .modal-body").html(message);
  $("#confirm_btn").on("click", confirm_callback);
  
  if(cancel_callback === undefined) {
    $("#cancel_btn").addClass('hidden');
  } else {
    $("#cancel_btn").on("click", cancel_callback);
  }

  if(confirm_callback === undefined && cancel_callback === undefined) {
    $("#confirm_modal .modal-footer").addClass('hidden');
  }
  
  $("#confirm_modal").modal("show");
}