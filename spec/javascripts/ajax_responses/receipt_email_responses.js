import ReceiptEmailFactory from "./../../../app/frontend/javascripts/factories/ReceiptEmailHistoryFactory";

const ReceiptEmailResponses = {
  success: {
    activated: {
      status: 200,
      model: ReceiptEmailFactory.new(),
      responseText: "response body",
      activated: true
    },
    deactivated: {
      status: 200,
      model: ReceiptEmailFactory.new(),
      responseText: "response body",
      activated: false
    }
  },
  error: {
    activated: {
      status: 500,
      model: ReceiptEmailFactory.new(),
      responseText: "response body",
      activated: true
    }
  }
};

export default ReceiptEmailResponses;
