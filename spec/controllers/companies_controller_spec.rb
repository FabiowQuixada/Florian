require 'rails_helper'

describe CompaniesController, type: :controller do
  before(:each) do
    sign_in User.first
  end

  include_examples 'index request tests'
  include_examples 'new request tests'
  include_examples 'create request tests with invalid attributes', Company
  include_examples 'edit request tests', Company
  include_examples 'destroy tests', Company

  # TODO: should be called by include_examples 'create request tests with valid attributes', but it raises an error
  describe 'POST #create with valid attributes' do
    it { expect { post :create, klass => attributes_for(klass) }.to change { model_class.count }.by 1 }

    it 'redirects to index' do
      post :create, klass => attributes_for(klass)
      expect(response).to have_http_status :found
      expect(response).to redirect_to model_index_path
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      let(:model) { create :company }

      before(:each) do
        put :update, id: model.id, company: attributes_for(:company, registration_name: 'regname', name: 'Teste yeye')
        model.reload
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to companies_path }
      it { expect(assigns(:company)).to eq(model) }
      it { expect(model.registration_name).to eq('regname') }
      it { expect(model.name).to eq('Teste yeye') }
    end

    context 'with invalid attributes' do
      let(:model) { create :company }

      before(:each) do
        put :update, id: model.id, company: attributes_for(:company, cnpj: nil, name: nil)
        model.reload
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('_form') }
      it { expect(assigns(:company)).to eq(model) }
      it { expect(model.cnpj).not_to be_nil }
      it { expect(model.name).not_to be_nil }
    end
  end
end
