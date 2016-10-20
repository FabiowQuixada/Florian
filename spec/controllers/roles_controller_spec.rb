require 'rails_helper'

describe RolesController, type: :controller do
  context 'model destruction' do
    let(:sucess_msg) { { message: Role.new.was('destroyed'), success: true }.to_json }
    let(:error_msg) { { message: I18n.t('errors.deletion'), success: false }.to_json }
    let(:non_admin_msg) { { message: I18n.t('errors.unpermitted_action'), success: false }.to_json }
    let(:dependent_objects) { { message: I18n.t('errors.messages.restrict_dependent_destroy.many', record: 'users'), success: false }.to_json }

    describe 'successfully deletes model as admin' do
      let(:role) { Role.where(name: 'Grupo sem usuario').first }
      before(:each) do
        sign_in User.first
      end

      it 'via ajax' do
        count = Role.count
        xhr :delete, :destroy, id: role.id
        expect(Role.count).to eq count - 1
        expect(response.body).to eq(sucess_msg)
      end

      it 'common request' do
        count = Role.count
        xhr :delete, :destroy, id: role.id
        expect(Role.count).to eq count - 1
        expect(response.body).to eq(sucess_msg)
      end
    end

    describe 'cant destroy role with dependent users' do
      before :each do
        sign_in User.first
      end

      it 'via ajax' do
        count = Role.count
        xhr :delete, :destroy, id: Role.first.id
        expect(Role.count).to eq count
        expect(response.body).to eq(dependent_objects)
      end

      it 'common request' do
        count = Role.count
        xhr :delete, :destroy, id: Role.first.id
        expect(Role.count).to eq count
        expect(response.body).to eq(dependent_objects)
      end
    end

    describe 'does not destroy model as common user' do
      before :each do
        sign_in User.last
      end

      it 'via ajax' do
        count = Role.count
        xhr :delete, :destroy, id: Role.first.id
        expect(Role.count).to eq count
        # expect(response.body).to eq(non_admin_msg)
      end

      it 'common request' do
        count = Role.count
        xhr :delete, :destroy, id: Role.first.id
        expect(Role.count).to eq count
        # expect(response.body).to eq(non_admin_msg)
      end
    end
  end

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
        let(:model) { create :role }

        before(:each) do
          put :update, id: model.id, role: attributes_for(:role, name: 'Joao')
          model.reload
        end

        it { expect(response).to have_http_status(:found) }
        it { expect(response).to redirect_to roles_path }
        it { expect(assigns(:role)).to eq(model) }
        it { expect(model.name).to eq('Joao') }
      end

      context 'with invalid attributes' do
        let(:model) { create :role }

        before(:each) do
          put :update, id: model.id, role: attributes_for(:role, name: nil)
          model.reload
        end

        it { expect(response).to have_http_status(:ok) }
        it { expect(response).to render_template('_form') }
        it { expect(assigns(:role)).to eq(model) }
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
      it { expect(flash[:alert]).to eq I18n.t('alert.access_denied') }
    end

    context 'tries to GET #new' do
      before(:each) do
        get :new
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to root_path }
      it { expect(flash[:alert]).to eq I18n.t('alert.access_denied') }
    end

    context 'tries to POST #create' do
      before(:each) do
        post :create, role: attributes_for(:role)
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to root_path }
      it { expect(flash[:alert]).to eq I18n.t('alert.access_denied') }
    end

    context 'tries to GET #edit' do
      before(:each) do
        get :edit, id: Role.first.id
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to root_path }
      it { expect(flash[:alert]).to eq I18n.t('alert.access_denied') }
    end

    context 'tries to PUT #update' do
      before(:each) do
        put :update, id: Role.first.id, role: attributes_for(:role)
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to root_path }
      it { expect(flash[:alert]).to eq I18n.t('alert.access_denied') }
    end
  end
end
