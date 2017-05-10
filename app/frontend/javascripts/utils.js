export const sum = css_input_selector => {
  // const nonExtraTab = field => (!$(field).hasClass("extra_tab"));
  let sum = 0;

  $(css_input_selector).each((i, field) => {
    sum = +sum + +$(field).val();
  });

  // $(css_input_selector).reduce( (total, field) => total + $(field).val() );

  return sum;
};
