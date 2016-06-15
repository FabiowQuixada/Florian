require 'rails_helper'

describe CompaniesController, type: :controller do
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
      it 'creates a new company' do
        expect { post :create, company: attributes_for(:company) }.to change { Company.count }.by(1)
      end

      it 'redirects to index' do
        post :create, company: attributes_for(:company)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to companies_path
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new company' do
        expect { post :create, company: attributes_for(:company, :invalid) }.not_to change { Company.count }
      end

      it 're-renders new' do
        post :create, company: attributes_for(:company, :invalid)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template '_form'
      end
    end
  end

  describe 'GET #edit' do
    before(:each) do
      get :edit, id: create(:company)
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('_form') }
    it { expect(response).to be_success }
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      before(:each) do
        @model = create :company
        put :update, id: @model.id, company: attributes_for(:company, registration_name: 'regname', name: 'Teste yeye')
        @model.reload
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to companies_path }
      it { expect(assigns(:company)).to eq(@model) }
      it { expect(@model.registration_name).to eq('regname') }
      it { expect(@model.name).to eq('Teste yeye') }
    end

    context 'with invalid attributes' do
      before(:each) do
        @model = create :company
        put :update, id: @model.id, company: attributes_for(:company, cnpj: nil, name: nil)
        @model.reload
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('_form') }
      it { expect(assigns(:company)).to eq(@model) }
      it { expect(@model.cnpj).not_to be_nil }
      it { expect(@model.name).not_to be_nil }
    end
  end

    describe 'Successfully deletes model as admin' do
    before(:each) do
      sign_in User.first
      create :company
      @n = Company.count
      @model = Company.first
      
      @sucess_msg = { message: @model.was('destroyed'), success: true }.to_json
      @error_msg = { message: I18n.t('errors.deletion'), success: false }.to_json
      @non_admin_msg = { message: I18n.t('errors.unpermitted_action'), success: false }.to_json
    end

    context 'Successfully destroys model via ajax' do
      before(:each) do
        xhr :delete, :destroy, id: @model.id
      end
      
      it { expect(Company.count).to eq(@n-1) }
      it { expect(response.body).to eq(@sucess_msg) }
    end
  end

  describe 'Doesnt destroy model as common user' do
    before(:each) do
      sign_in User.last
      create :company
      @n = Company.count
      @model = Company.first
      
      @sucess_msg = { message: @model.was('destroyed'), success: true }.to_json
      @error_msg = { message: I18n.t('errors.deletion'), success: false }.to_json
      @non_admin_msg = { message: I18n.t('errors.unpermitted_action'), success: false }.to_json
    end

    context 'Common user cant destroy model via ajax' do
      before(:each) do
        xhr :delete, :destroy, id: @model.id
      end
      
      it { expect(Company.count).to eq(@n) }
      it { expect(response.body).to eq(@non_admin_msg) }
    end
  end
end
