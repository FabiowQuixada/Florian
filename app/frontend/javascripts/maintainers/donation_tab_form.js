import I18n from './../i18n'
import { on_page } from './../application'
import Constants from './../server_constants'
import moment from 'moment';

$(() => { if(on_page('maintainers', 'form')) maintainers_donation_tab_form() });

const maintainers_donation_tab_form = () => {
  const cant_set_parcels = () => {
    const frequency = $('#maintainer_payment_frequency').val();

    return !frequency || frequency === '' || frequency === Constants.payment_freq.undefined || frequency === Constants.payment_freq.other;
  }

  const toogle_parcel_qty_field = () => {
    if(cant_set_parcels()) {
      $('#maintainer_payment_period').prop('readonly', true);
      $('#maintainer_payment_period').val('');
    } else {
      $('#maintainer_payment_period').prop('readonly', false);
    }
  }

  const set_last_parcel_date = () => {
    const first_date = $('#maintainer_first_parcel').val();
    const frequency = $('#maintainer_payment_frequency').val();
    const parcel_qty = $('#maintainer_payment_period').val();
    const last_date = $('#maintainer_last_parcel');

    if(!first_date || cant_set_parcels() || !parcel_qty) {
      last_date.val('');
      return;
    }

    let frequency_type;
    let temp = parcel_qty;

    if(frequency == Constants.payment_freq.diary) {
      frequency_type = 'days';
    } else if(frequency == Constants.payment_freq.weekly) {
      frequency_type = 'weeks';
    } else if(frequency == Constants.payment_freq.monthly) {
      frequency_type = 'months';
    } else if(frequency == Constants.payment_freq.bimonthly) {
      temp = 3;
      frequency_type = 'months';
    } else if(frequency == Constants.payment_freq.semiannually) {
      temp = 6;
      frequency_type = 'months';
    } else if(frequency == Constants.payment_freq.annually) {
      frequency_type = 'years';
    }

    if(parcel_qty !== 0 || (frequency_type !== undefined && frequency_type !== '')) {
      const date_format = I18n.t('date.formats.javascript_format.date').toUpperCase();
      last_date.val(moment(first_date, date_format).add((temp-1), frequency_type).format(date_format));
    } else {
      last_date.val('');
    }
  }

  toogle_parcel_qty_field();
  set_last_parcel_date();

  $('#maintainer_first_parcel').on('change', set_last_parcel_date);
  $('#maintainer_payment_period').on('change', set_last_parcel_date);
  $('#maintainer_payment_frequency').on('change', set_last_parcel_date);
  $('#maintainer_payment_frequency').change(toogle_parcel_qty_field);
}
