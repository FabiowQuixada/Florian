import { on_page } from './../application'

$(() => { if(on_page('bills', 'index')) bills_index() });

const bills_index = () => {
  $('#graphs_btn').click( () => $('#graphs_modal').modal('show'));
}
