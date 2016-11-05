require 'rails_helper'

describe ReceiptEmail, js: true, type: :request do
  before :each do
    login_as_admin
    visit new_receipt_email_path
  end

  include_examples 'an e-mail address table', ['recipients_array']
end
