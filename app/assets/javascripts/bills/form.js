import { on_page, currency_sum } from './../application.js'
import { format_competence } from './../dates.js'

$(() => { if(on_page('bills', 'form')) bills_form(); });

const bills_form = () => {
  const before_submit_or_leave = () => format_competence('bill_aux_competence', 'bill_competence')

  $('#main_form').on('submit', e => before_submit_or_leave());
  $('#bill_aux_competence').on('change', () => before_submit_or_leave());
  $('#summable-inputs input').on('change', () => $('#bill_totals').val(currency_sum('#summable-inputs input')));
}
