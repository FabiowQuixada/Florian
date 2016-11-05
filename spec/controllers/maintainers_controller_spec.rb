require 'rails_helper'

describe MaintainersController, type: :controller do
  before :each do
    sign_in User.first
  end

  include_examples 'index request tests'
  include_examples 'new request tests'
  include_examples 'create request tests with invalid attributes'
  include_examples 'edit request tests'
  include_examples 'update request tests', registration_name: 'regname', name: 'Teste yeye'
  include_examples 'destroy tests'

  # TODO: should be called by include_examples 'create request tests with valid attributes', but it raises an error
  describe 'POST #create with valid attributes' do
    it { expect { post :create, klass => attributes_for(klass) }.to change { model_class.count }.by 1 }

    it 'redirects to index' do
      post :create, klass => attributes_for(klass)
      expect(response).to have_http_status :found
      expect(response).to redirect_to model_index_path
    end
  end
end
