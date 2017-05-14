import { on_controller } from "./../application";

$(() => {
  if(on_controller("errors")) {
    $(".back_btn").on("click", () => parent.history.back());
  }
});
