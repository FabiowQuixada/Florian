require 'rails_helper'

describe ReceiptEmail, type: :request do
  let(:fields) { ['recipients_array'] }

  before :each do
    login_as_admin
    visit new_receipt_email_path
  end

  include_examples 'an e-mail address table'
end
