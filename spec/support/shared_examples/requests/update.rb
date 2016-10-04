shared_examples 'update request tests' do |changing_attrs|
  # Pass mandatory attributes, since ther're going to be set to nil in the invalid tests
  include_examples 'update request tests with valid attributes', changing_attrs
  include_examples 'update request tests with invalid attributes', changing_attrs
end

shared_examples 'update request tests with valid attributes' do |changing_attrs|
  describe 'POST #update with valid attributes' do
    let(:model) { model_class.first }

    before :each do
      put :update, id: model.id, klass => attributes_for(klass, changing_attrs)
      model.reload
    end

    it { expect(response).to have_http_status :found }
    it { expect(response).to redirect_to model_index_path }
    it { expect(assigns(klass)).to eq model }
    it { changing_attrs.each { |att| expect(model.send(att[0])).to eq att[1] } }
  end
end

shared_examples 'update request tests with invalid attributes' do |changing_attrs|
  describe 'POST #update with invalid attributes' do
    let(:model) { model_class.first }
    let(:changing_attrs_to_nil) do
      changing_attrs_to_nil = {}
      changing_attrs.each { |att| changing_attrs_to_nil[att[0]] = nil }
      changing_attrs_to_nil
    end

    before :each do
      put :update, id: model.id, klass => attributes_for(klass, changing_attrs_to_nil)
      model.reload
    end

    it { expect(response).to have_http_status :ok }
    it { expect(response).to render_template '_form' }
    it { expect(assigns(klass)).to eq model }
    it { changing_attrs.each { |att| expect(model.send(att[0])).not_to be_nil } }
  end
end
