require 'rails_helper'

describe DonationsController, type: :controller do
  before(:each) do
    sign_in User.first
  end

  include_examples 'index request tests'
  include_examples 'new request tests'
  include_examples 'create request tests'
  include_examples 'edit request tests'
  include_examples 'destroy tests'

  describe 'POST #create_and_new' do
    context 'with valid attributes' do
      it 'creates a new donation' do
        expect { post :create_and_new, donation: build(:donation).attributes }.to change { Donation.count }.by(1)
      end

      it 'redirects to new' do
        post :create_and_new, donation: build(:donation).attributes

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_donation_path
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new donation' do
        expect { post :create_and_new, donation: attributes_for(:donation, :invalid) }.not_to change { Donation.count }
      end

      it 're-renders new' do
        post :create_and_new, donation: attributes_for(:donation, :invalid)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template('_form')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      let(:model) { create :donation }

      before(:each) do
        put :update, id: model.id, donation: attributes_for(:donation, remark: 'remark', value: 1.14)
        model.reload
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to donations_path }
      it { expect(assigns(:donation)).to eq(model) }
      it { expect(model.remark).to eq('remark') }
      it { expect(model.value).to eq(ActionController::Base.helpers.number_to_currency(1.14)) }
    end

    context 'with invalid attributes' do
      let(:model) { create :donation }

      before(:each) do
        put :update, id: model.id, donation: attributes_for(:donation, remark: nil, value: nil)
        model.reload
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('_form') }
      it { expect(assigns(:donation)).to eq(model) }
      it { expect(model.remark).not_to be_nil }
      it { expect(model.value).not_to eq(ActionController::Base.helpers.number_to_currency(1.14)) }
    end
  end
end
