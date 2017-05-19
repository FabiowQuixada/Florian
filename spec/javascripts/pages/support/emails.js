export const add_email_to_table = (field_name, email) => {
  $(`#${field_name}_recipients_table > tbody:last-child`).append(`
    <tr class="${field_name}_email_recipient">
      <td class="is_persisted">false</td>
      <td class="recipient_email middle">${email}</td>
      <td class="button-wrapper"><img class="remove_btn" /></td>
    </tr>
  `);
};
