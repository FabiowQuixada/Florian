require 'rails_helper'

describe UsersController, type: :controller do
  # == Admin ================================================================================================
  context 'Admin' do
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
      # context 'with valid attributes' do
      #   it 'creates a new user' do
      #     expect {  post :create, user: build(:user).attributes }.to change { User.count }.by(1)
      #   end

      #   it 'redirects to index' do
      #     post :create, user: build(:user).attributes

      #     expect(response).to have_http_status(:found)
      #     expect(response).to redirect_to admin_users_path
      #     expect(response).to be_success
      #   end
      # end

      context 'with invalid attributes' do
        it 'does not create a new user' do
          expect { post :create, user: attributes_for(:user, :invalid) }.not_to change { User.count }
        end

        it 're-renders new' do
          post :create, user: attributes_for(:user, :invalid)

          expect(response).to have_http_status(:ok)
          expect(response).to render_template '_form'
          expect(response).to be_success
        end
      end
    end

    describe 'GET #edit' do
      before(:each) do
        get :edit, id: create(:user)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('_form') }
      it { expect(response).to be_success }
    end

    describe 'PUT #update' do
      context 'with valid attributes' do
        let(:model) { create :user }

        before(:each) do
          put :update, id: model.id, user: attributes_for(:user, name: 'Joao')
          model.reload
        end

        it { expect(response).to have_http_status(:found) }
        it { expect(response).to redirect_to users_path }
        it { expect(assigns(:user)).to eq(model) }
        it { expect(model.name).to eq('Joao') }
      end

      context 'with invalid attributes' do
        let(:model) { create :user }

        before(:each) do
          put :update, id: model.id, user: attributes_for(:user, name: nil)
          model.reload
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to render_template('_form') }
        it { expect(assigns(:user)).to eq(model) }
        it { expect(model.name).not_to be_nil }
      end
    end
  end

  # == Common user ==============================================================================================

  context 'Common user' do
    before(:each) do
      sign_in User.last
    end

    context 'tries to GET #new' do
      before(:each) do
        get :index
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to root_path }
      it { expect(flash[:alert]).to eq 'Acesso negado!' }
    end

    context 'tries to GET #new' do
      before(:each) do
        get :new
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to root_path }
      it { expect(flash[:alert]).to eq 'Acesso negado!' }
    end

    context 'tries to POST #create' do
      before(:each) do
        post :create, user: attributes_for(:user, name: 'Joao')
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to root_path }
      it { expect(flash[:alert]).to eq 'Acesso negado!' }
    end

    context 'tries to GET #edit' do
      before(:each) do
        get :edit, id: User.first.id
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to root_path }
      it { expect(flash[:alert]).to eq 'Acesso negado!' }
    end

    context 'tries to PUT #update' do
      before(:each) do
        put :update, id: User.first.id, user: attributes_for(:user, name: 'Joao')
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to root_path }
      it { expect(flash[:alert]).to eq 'Acesso negado!' }
    end
  end
end
