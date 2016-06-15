require 'rails_helper'

describe RolesController, type: :controller do
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
      context 'with valid attributes' do
        it 'creates a new role' do
          expect { post :create, role: attributes_for(:role) }.to change { Role.count }.by(1)
        end

        it 'redirects to index' do
          post :create, role: attributes_for(:role)

          expect(response).to have_http_status(:found)
          expect(response).to redirect_to roles_path
        end
      end

      context 'with invalid attributes' do
        it 'does not create a new role' do
          expect { post :create, role: attributes_for(:role, :invalid) }.not_to change { Role.count }
        end

        it 're-renders new' do
          post :create, role: attributes_for(:role, :invalid)

          expect(response).to have_http_status(:ok)
          expect(response).to render_template '_form'
          expect(response).to be_success
        end
      end
    end

    describe 'GET #edit' do
      before(:each) do
        get :edit, id: create(:role)
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('_form') }
      it { expect(response).to be_success }
    end

    describe 'PUT #update' do
      context 'with valid attributes' do
        before(:each) do
          @model = create :role
          put :update, id: @model.id, role: attributes_for(:role, name: 'Joao')
          @model.reload
        end

        it { expect(response).to have_http_status(:found) }
        it { expect(response).to redirect_to roles_path }
        it { expect(assigns(:role)).to eq(@model) }
        it { expect(@model.name).to eq('Joao') }
      end

      context 'with invalid attributes' do
        before(:each) do
          @model = create :role
          put :update, id: @model.id, role: attributes_for(:role, name: nil)
          @model.reload
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to render_template('_form') }
        it { expect(assigns(:role)).to eq(@model) }
        it { expect(@model.name).not_to be_nil }
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
        post :create, role: attributes_for(:role)
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to root_path }
      it { expect(flash[:alert]).to eq 'Acesso negado!' }
    end

    context 'tries to GET #edit' do
      before(:each) do
        get :edit, id: Role.first.id
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to root_path }
      it { expect(flash[:alert]).to eq 'Acesso negado!' }
    end

    context 'tries to PUT #update' do
      before(:each) do
        put :update, id: Role.first.id, role: attributes_for(:role)
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to root_path }
      it { expect(flash[:alert]).to eq 'Acesso negado!' }
    end
  end
end
