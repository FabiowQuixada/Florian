const number_of_tabs = {};

export const set_number_of_tabs = (tab_type, number) => {
  number_of_tabs[tab_type] = number;

  for(let i = 0; i < number_of_tabs[tab_type]; ++i) {
    $(`#${tab_type}_tab_${i}_title`).on("click", () => hide_all_tabs_except(tab_type, i));
  }

  hide_all_tabs_except(tab_type, 0);
};

export const hide_all_tabs_except = (tab_type, tab_id = 0) => {
  for(let i = 0; i < number_of_tabs[tab_type]; ++i) {
    $(`#${tab_type}_tab_${i}_title`).removeClass("active");
    $(`#${tab_type}_tab_${i}`).addClass("hidden");
  }

  $(`#${tab_type}_tab_${tab_id}`).removeClass("hidden");
  $(`#${tab_type}_tab_${tab_id}_title`).addClass("active");
};
