shared_examples 'create request tests' do |class_name|
  include_examples 'create request tests with valid attributes', class_name
  include_examples 'create request tests with invalid attributes', class_name
end

shared_examples 'create request tests with valid attributes' do |class_name|
  describe 'POST #create with valid attributes' do
    let(:klass) { class_name.name.underscore }
    let(:model_index_path) { send("#{class_name.model_name.route_key}_path") }

    it { expect { post :create, klass => build(class_name).attributes }.to change { class_name.count }.by 1 }

    it 'redirects to index' do
      post :create, klass => build(class_name).attributes
      expect(response).to have_http_status :found
      expect(response).to redirect_to model_index_path
    end
  end
end

shared_examples 'create request tests with invalid attributes' do |class_name|
  describe 'POST #create with invalid attributes' do
    let(:klass) { class_name.name.underscore }
    let(:model_index_path) { send("#{class_name.model_name.route_key}_path") }

    it { expect { post :create, klass => attributes_for(class_name, :invalid) }.not_to change { class_name.count } }

    it 're-renders new' do
      post :create, klass => attributes_for(klass, :invalid)
      expect(response).to have_http_status :ok
      expect(response).to render_template '_form'
    end
  end
end
