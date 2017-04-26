// This file was generated through erb templating. Any changes you do directly
// in this file will be overriden when the "build_client_data:all" rake task is run;

const ServerFunctions = {
  paths: {
    send_test_receipt_email: (id) => "/receipt_emails/-1/send_test".replace("-1", id),
    resend_receipt_email: (id) => "/receipt_emails/-1/resend".replace("-1", id),
    index: model_name => "/receipt_emails".replace("receipt_emails", model_name),
  }
}

export default ServerFunctions
