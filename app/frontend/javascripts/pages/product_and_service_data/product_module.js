import Constants from "./../../server_constants";
import { sum } from "./../../utils";

export const update_totals_from_tab = i => {
  $(`#w${i}_product_total`).val(sum(`.product_w${i}`));
};

export const setup_listeners = () => {
  $("body").on(
    "change",
    ".product_input",
    () => { update_totals_for_each_tab(); }
  );
};

export const update_totals_tab = () => {
  Constants.products_array.forEach( product => {
    $(`#w5_product_${product}`).val(sum(`.product_${product}:not(.extra_tab)`));
  });

  const index = Constants.week_totals_number - 1;
  update_totals_from_tab(index);
};

export const update_totals_for_each_tab = () => {
  for (let i = 0; i <= Constants.week_final_number; i++) {
    update_totals_from_tab(i);
  }

  update_totals_tab();
};

export const copy_data_from_totals_to_final_tab = () => {
  Constants.products_array.forEach( product => {
    $(`#w6_product_${product}`).val(sum(`#w5_product_${product}`));
  });

  const index = Constants.week_final_number - 1;
  update_totals_from_tab(index);
};

export const set_hidden_week_field = (attr, source_week_number) => {
  const target = $(`#hiddenweek_product_${attr}`);
  const source = $(`#w${source_week_number}_product_${attr}`);
  target.val(source.val());
};

export const copy_data_to_hidden_form = source_week_number => {
  Constants.products_array.forEach( product => {
    set_hidden_week_field(product, source_week_number);
  });

  set_hidden_week_field("id", source_week_number);
};
