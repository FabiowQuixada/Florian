require 'rails_helper'

describe BillsController, type: :controller do
  before :each do
    sign_in User.first
  end

  include_examples 'index request tests'
  include_examples 'new request tests'
  include_examples 'create request tests with valid attributes', Bill
  include_examples 'edit request tests', Bill
  include_examples 'destroy tests', Bill


  describe 'POST #create' do
    context 'with invalid attributes' do
      it { expect { post :create, bill: attributes_for(:bill, :invalid) }.to change { Bill.count }.by(1) }

      it 're-renders new' do
        post :create, bill: attributes_for(:bill, :invalid)

        expect(response).to have_http_status(:found)
        # This is a special case, which should not be tested -- just for the record
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

  context 'private methods' do
    let(:year) { 2016 }
    let(:month) { 3 }
    let(:bills_controller) { described_class.new }
    let(:bill) { Bill.first }

    describe '#initialize_year' do
      let(:zeroed_year) do
        expected = {}
        expected[year] = []
        (0..11).each do |month|
          expected[year][month] ||= ['0,00', '0,00', '0,00']
        end

        expected
      end

      it 'initializes graph`s year' do
        bills_controller.send('initialize_year', year)
        expect(bills_controller.instance_variable_get(:'@graph_data')).to eq zeroed_year
      end
    end

    describe '#populate_month' do
      let(:expected) { [bill.water.to_s, bill.energy.to_s, bill.telephone.to_s] }

      it 'populates graph data' do
        bills_controller.send('populate_month', bill, month, year)
        expect(bills_controller.instance_variable_get(:'@graph_data')[year][month - 1]).to eq expected
      end
    end
  end
end
