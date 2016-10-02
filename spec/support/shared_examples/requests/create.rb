shared_examples 'create request tests' do 
  include_examples 'create request tests with valid attributes'
  include_examples 'create request tests with invalid attributes'
end

shared_examples 'create request tests with valid attributes' do
  describe 'POST #create with valid attributes' do
    it { expect { post :create, klass => build(klass).attributes }.to change { model_class.count }.by 1 }

    it 'redirects to index' do
      post :create, klass => build(klass).attributes
      expect(response).to have_http_status :found
      expect(response).to redirect_to model_index_path
    end
  end
end

shared_examples 'create request tests with invalid attributes' do
  describe 'POST #create with invalid attributes' do
    it { expect { post :create, klass => attributes_for(klass, :invalid) }.not_to change { model_class.count } }

    it 're-renders new' do
      post :create, klass => attributes_for(klass, :invalid)
      expect(response).to have_http_status :ok
      expect(response).to render_template '_form'
    end
  end
end
