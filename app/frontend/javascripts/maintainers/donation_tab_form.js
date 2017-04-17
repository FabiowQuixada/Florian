import { on_page } from './../application'
import Constants from './../server_constants'
import { set_datepicker } from './../dates'

$(() => { if(on_page('maintainers', 'form')) maintainers_donation_tab_form() });

let build_donation;
let clean_donation_fields;
let add_donation;
let validate_donation;
let new_donations;

const maintainers_donation_tab_form = () => {
  // Temporary donations have negative id;
  let temp_donation_id = -1;

  new_donations = () => {
    let new_donation = false;

    $("#donations_table td.donation_id").each((index, td) => {
      if(parseInt($(td).text()) < 0)
        new_donation = true;
    });

    return new_donation;
  }

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

  validate_donation = (donation) => {
    const errors = new Array();

    if(!donation.donation_date) {
      const attribute = I18n.t("activerecord.attributes.donation.date");
      errors.push(I18n.t("errors.messages.blank", { attribute }));
    }

    if((!donation.value || donation.value === to_money(0)) && !donation.remark) {
      errors.push(I18n.t('errors.donation.value_or_remark'));
    }

    if(errors.length > 0) {
      display_error(errors, 'donation');
    }

    return errors.length === 0;
  }

  add_donation = (donation) => {
    if(validate_donation(donation)) {
      $.ajax({
        url: Constants.paths.donation_row_maintainers, 
        data: { donation },
        success: result => $('#donations_table > tbody:last-child').append(result)
      });

      temp_donation_id -= 1;
      clean_donation_fields();
      $('#no_donations_row').addClass('hidden');
    }
  }

  build_donation = () => {
    const donation_date = $('#new_donation_date').val();
    const value = $('#new_donation_value').val();
    const remark = $('#new_donation_remark').val();

    return {
      id: temp_donation_id,
      donation_date,
      value,
      remark
    }
  }

  clean_donation_fields = () => {
    $('#new_donation_date').val('');
    $('#new_donation_value').val(to_money(0));
    $('#new_donation_remark').val('');

    hide_errors_from_box('donation');
  }

  toogle_parcel_qty_field();
  set_last_parcel_date();

  $('#maintainer_first_parcel').on('change', set_last_parcel_date);
  $('#maintainer_payment_period').on('change', set_last_parcel_date);
  $('#maintainer_payment_frequency').on('change', set_last_parcel_date);
  $('#maintainer_payment_frequency').change(toogle_parcel_qty_field);
  $('body').on('click', '#new_donation_btn', set_datepicker);

  $('#add_donation_btn').on('click', () => {
    donation = build_donation();
    add_donation(donation);
  });

  $('body').on('click', '.remove_donation_btn', e => {
    const elem = $(e.currentTarget);
    const id = elem.closest('.donation_row').find('.donation_id').text();

    $(`#donation_${id}_row`).remove();

    if(document.getElementById("donations_table").rows.length == 2) {
      $('#no_donations_row').removeClass('hidden');
    }

    if(id > 0) {
      $('#maintainer_donations_to_be_deleted').val(`${$('#maintainer_donations_to_be_deleted').val()}${id},`);
    }
  });
}