import { on_page } from './../application'

$(() => { if(on_page('donations', 'form')) donations_form() });

const donations_form = () => {
  $('#create_and_new_btn').on('click', e => {
    $('form').get(0).setAttribute('action', Constants.paths.create_and_new_donations);
    $("#main_form").submit();
  });
}