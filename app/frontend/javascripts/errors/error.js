import { on_controller } from './../application.js'

$(() => {
  if(on_controller('errors')) {
   $('.back_btn').on('click', () => parent.history.back())
  }
});
