require 'rails_helper'

describe BillsController, type: :controller do
  before :each do
    sign_in User.first
  end

  include_examples 'index request tests'
  include_examples 'new request tests'
  include_examples 'create request tests with valid attributes'
  include_examples 'edit request tests'
  include_examples 'update request tests', water: 3.14, energy: 1.14
  include_examples 'destroy tests'

  describe 'POST #create' do
    context 'with invalid attributes' do
      it { expect { post :create, bill: attributes_for(:bill, :invalid) }.to change { Bill.count }.by(1) }

      it 're-renders new' do
        post :create, bill: attributes_for(:bill, :invalid)

        expect(response).to have_http_status :found
        # This is a special case, which should not be tested -- just for the record
        # expect(response).to redirect_to new_bill_path
      end
    end
  end
end
