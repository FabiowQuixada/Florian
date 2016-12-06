require 'rails_helper'

describe Bill, js: true, type: :request do
  let(:bill) { described_class.first }

  before :each do
    login_as_admin
    visit edit_bill_path bill
  end

  it 'updates totals field properly' do
    fill_fields
    input_blur
    expect(first('#bill_totals').value).to eq '2,999,999.97'
  end

  it { expect(first('#bill_totals').value).to eq ActionController::Base.helpers.number_to_currency(bill.total.to_f, unit: '') }

  # Helper methods ###################################

  def fill_fields
    first('#bill_water').set(99_999_999)
    first('#bill_energy').set(99_999_999)
    first('#bill_telephone').set(99_999_999)
  end
end
