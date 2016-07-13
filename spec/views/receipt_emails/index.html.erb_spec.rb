require 'rails_helper'

describe 'receipt_emails/index', type: :view do
  before :each do
    current_user = User.first
    allow(view).to receive(:current_user).and_return(current_user)
  end

  let(:class_name) { ReceiptEmail }
  it_behaves_like 'an index view'
end
