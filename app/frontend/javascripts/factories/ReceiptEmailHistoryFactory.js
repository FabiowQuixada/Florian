let email_history_temp_id = -1;

class ReceiptEmailHistoryFactory {
  static new(
            id = email_history_temp_id--,
            date = "01/01/2001",
            value = "3.14",
            type = "Test",
            user = "Jonh"
           ) {
    return {
      id,
      date,
      value,
      type,
      user
    };
  }
}

export default ReceiptEmailHistoryFactory;
