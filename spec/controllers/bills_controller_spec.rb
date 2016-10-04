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

        expect(response).to have_http_status(:found)
        # This is a special case, which should not be tested -- just for the record
        # expect(response).to redirect_to new_bill_path
      end
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
