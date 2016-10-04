require 'rails_helper'

describe DonationsController, type: :controller do
  before :each do
    sign_in User.first
  end

  include_examples 'index request tests'
  include_examples 'new request tests'
  include_examples 'create request tests'
  include_examples 'edit request tests'
  include_examples 'update request tests', remark: 'remark', value: 1.14
  include_examples 'destroy tests'

  describe 'POST #create_and_new' do
    context 'with valid attributes' do
      it { expect { post :create_and_new, donation: build(:donation).attributes }.to change { Donation.count }.by 1 }

      it 'redirects to new' do
        post :create_and_new, donation: build(:donation).attributes
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_donation_path
      end
    end

    context 'with invalid attributes' do
      it { expect { post :create_and_new, donation: attributes_for(:donation, :invalid) }.not_to change { Donation.count } }

      it 're-renders new' do
        post :create_and_new, donation: attributes_for(:donation, :invalid)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('_form')
      end
    end
  end
end
