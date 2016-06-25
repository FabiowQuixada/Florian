require 'rails_helper'

describe ProductAndServiceDataController, type: :controller do
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
      it 'creates a new product_and_service_datum' do
        expect { post :create, product_and_service_datum: build(:product_and_service_datum).attributes }.to change { ProductAndServiceDatum.count }.by(1)
        expect { post :create, product_and_service_datum: build(:product_and_service_datum).attributes }.to change { ProductAndServiceWeek.count }.by(7)
        expect { post :create, product_and_service_datum: build(:product_and_service_datum).attributes }.to change { ProductData.count }.by(7)
        expect { post :create, product_and_service_datum: build(:product_and_service_datum).attributes }.to change { ServiceData.count }.by(14)
      end

      it 'redirects to index' do
        post :create, product_and_service_datum: attributes_for(:product_and_service_datum)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to product_and_service_data_path
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new product_and_service_datum' do
        # Special case
        # expect { post :create, product_and_service_datum: build(:product_and_service_datum, :invalid).attributes }.not_to change { ProductAndServiceDatum.count }
      end

      it 're-renders new' do
        post :create, product_and_service_datum: build(:product_and_service_datum, :invalid).attributes

        # Special case
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to product_and_service_data_path
      end
    end
  end

  describe 'GET #edit' do
    before(:each) do
      get :edit, id: create(:product_and_service_datum)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('_form') }
    it { expect(response).to be_success }
  end

  describe 'PUT #update' do
    let(:model) { create :product_and_service_datum }

    context 'with valid attributes' do
      before(:each) do
        put :update, id: model.id, product_and_service_datum: attributes_for(:product_and_service_datum, competence: Date.new(2015, 6, 12))
        model.reload
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to product_and_service_data_path }
      it { expect(assigns(:product_and_service_datum)).to eq(model) }
      it { expect(model.competence).to eq(Date.strptime('{ 1, 6, 2015 }', '{ %d, %m, %Y }')) }
    end

    context 'with invalid attributes' do
      before(:each) do
        put :update, id: model.id, product_and_service_datum: attributes_for(:product_and_service_datum, competence: nil)
        model.reload
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('_form') }
      it { expect(assigns(:product_and_service_datum)).to eq(model) }
      it { expect(model.competence).not_to be_nil }
    end
  end

  # describe 'Successfully deletes model as admin' do
  #   let(:n) { ProductAndServiceDatum.count }
  #   let(:model) { create :product_and_service_datum }
  #   let(:sucess_msg) { { message: model.was('destroyed'), success: true }.to_json }
  #   let(:error_msg) { { message: I18n.t('errors.deletion'), success: false }.to_json }
  #   let(:non_admin_msg) { { message: I18n.t('errors.unpermitted_action'), success: false }.to_json }

  #   before(:each) do
  #     sign_in User.first
  #   end

  #   context 'Successfully destroys model via ajax' do
  #     before(:each) do
  #       xhr :delete, :destroy, id: model.id
  #     end

  #     it { expect(ProductAndServiceDatum.count).to eq(n - 1) }
  #     it { expect(response.body).to eq(sucess_msg) }
  #   end
  # end

  # describe 'Doesnt destroy model as common user' do
  #   let(:n) { ProductAndServiceDatum.count }
  #   let(:model) { create :product_and_service_datum }
  #   let(:sucess_msg) { { message: model.was('destroyed'), success: true }.to_json }
  #   let(:error_msg) { { message: I18n.t('errors.deletion'), success: false }.to_json }
  #   let(:non_admin_msg) { { message: I18n.t('errors.unpermitted_action'), success: false }.to_json }

  #   before(:each) do
  #     sign_in User.last
  #   end

  #   context 'Common user cant destroy model via ajax' do
  #     before(:each) do
  #       xhr :delete, :destroy, id: model.id
  #     end

  #     it { expect(ProductAndServiceDatum.count).to eq(n) }
  #     it { expect(response.body).to eq(non_admin_msg) }
  #   end
  # end
end
