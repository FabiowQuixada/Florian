let email_temp_id = -1;

class ReceiptEmailFactory {
  static new(
             id = email_temp_id--,
             recipients_array,
             value = "0.00",
             maintainer = "Jasmine Inc.",
             title = "Title",
             body = "Body",
             active = true
           ) {
    return {
      id,
      recipients_array,
      value,
      maintainer,
      title,
      body,
      active,
      history: []
    };
  }

  static with_history() {
    return {};
  }
}

export default ReceiptEmailFactory;
