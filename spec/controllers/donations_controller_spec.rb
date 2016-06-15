require 'rails_helper'

describe DonationsController, type: :controller do
  before(:each) do
    sign_in User.first
  end

  describe 'GET #index' do
    before(:each) do
      get :index
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('index') }
    it { expect(response).to be_success }
  end

  describe 'GET #new' do
    before(:each) do
      get :new
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template '_form' }
    it { expect(response).to be_success }
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before(:each) do
        post :create, donation: build(:donation).attributes
      end

      it 'creates a new donation' do
        expect { post :create, donation: build(:donation).attributes }.to change { Donation.count }.by(1)
      end

      it 'redirects to index' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to donations_path
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new donation' do
        expect { post :create, donation: attributes_for(:donation, :invalid) }.not_to change { Donation.count }
      end

      it 're-renders new' do
        post :create, donation: attributes_for(:donation, :invalid)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template('_form')
      end
    end
  end

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

  describe 'GET #edit' do
    before(:each) do
      get :edit, id: create(:donation)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('_form') }
    it { expect(response).to be_success }
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      before(:each) do
        @model = create :donation
        put :update, id: @model.id, donation: attributes_for(:donation, remark: 'remark', value: 1.14)
        @model.reload
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to donations_path }
      it { expect(assigns(:donation)).to eq(@model) }
      it { expect(@model.remark).to eq('remark') }
      it { expect(@model.value).to eq(ActionController::Base.helpers.number_to_currency(1.14)) }
    end

    context 'with invalid attributes' do
      before(:each) do
        @model = create :donation
        put :update, id: @model.id, donation: attributes_for(:donation, remark: nil, value: nil)
        @model.reload
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('_form') }
      it { expect(assigns(:donation)).to eq(@model) }
      it { expect(@model.remark).not_to be_nil }
      it { expect(@model.value).not_to eq(ActionController::Base.helpers.number_to_currency(1.14)) }
    end
  end

    describe 'Successfully deletes model as admin' do
    before(:each) do
      sign_in User.first
      create :donation
      @n = Donation.count
      @model = Donation.first
      
      @sucess_msg = { message: @model.was('destroyed'), success: true }.to_json
      @error_msg = { message: I18n.t('errors.deletion'), success: false }.to_json
      @non_admin_msg = { message: I18n.t('errors.unpermitted_action'), success: false }.to_json
    end

    context 'Successfully destroys model via ajax' do
      before(:each) do
        xhr :delete, :destroy, id: @model.id
      end
      
      it { expect(Donation.count).to eq(@n-1) }
      it { expect(response.body).to eq(@sucess_msg) }
    end
  end

  describe 'Doesnt destroy model as common user' do
    before(:each) do
      sign_in User.last
      create :donation
      @n = Donation.count
      @model = Donation.first
      
      @sucess_msg = { message: @model.was('destroyed'), success: true }.to_json
      @error_msg = { message: I18n.t('errors.deletion'), success: false }.to_json
      @non_admin_msg = { message: I18n.t('errors.unpermitted_action'), success: false }.to_json
    end

    context 'Common user cant destroy model via ajax' do
      before(:each) do
        xhr :delete, :destroy, id: @model.id
      end
      
      it { expect(Donation.count).to eq(@n) }
      it { expect(response.body).to eq(@non_admin_msg) }
    end
  end
end
