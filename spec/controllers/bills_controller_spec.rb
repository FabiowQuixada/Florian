require 'rails_helper'

describe BillsController, type: :controller do
  before(:each) do
    sign_in User.first
  end

  # TODO: Check list to graphs
  include_examples 'index request tests'
  include_examples 'new request tests'
  include_examples 'edit request tests', Bill
  include_examples 'destroy tests', Bill


  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new bill' do
        expect { post :create, bill: attributes_for(:bill) }.to change { Bill.count }.by(1)
      end

      it 'redirects to index' do
        post :create, bill: attributes_for(:bill)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to bills_path
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new bill' do
        expect { post :create, bill: attributes_for(:bill, :invalid) }.to change { Bill.count }.by(1)
      end

      it 're-renders new' do
        post :create, bill: attributes_for(:bill, :invalid)

        expect(response).to have_http_status(:found)
        # This is a special case, which should not be tested -- just for record
        # expect(response).to redirect_to new_bill_path
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      let(:model) { create :bill }

      before(:each) do
        put :update, id: model.id, bill: attributes_for(:bill, water: 3.14, energy: 1.14)
        model.reload
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to bills_path }
      it { expect(assigns(:bill)).to eq(model) }
      it { expect(model.water).to eq(ActionController::Base.helpers.number_to_currency(3.14)) }
      it { expect(model.energy).to eq(ActionController::Base.helpers.number_to_currency(1.14)) }
    end

    context 'with invalid attributes' do
      let(:model) { create :bill }

      before(:each) do
        put :update, id: model.id, bill: attributes_for(:bill, water: nil, energy: nil)
        model.reload
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('_form') }
      it { expect(assigns(:bill)).to eq(model) }
      it { expect(model.water).not_to eq(ActionController::Base.helpers.number_to_currency(3.14)) }
      it { expect(model.energy).not_to eq(ActionController::Base.helpers.number_to_currency(1.14)) }
    end
  end
end
