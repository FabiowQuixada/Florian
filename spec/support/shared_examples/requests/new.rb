shared_examples 'new request tests' do |_class_name|
  describe 'GET #new' do
    render_views

    before(:each) do
      get :new
    end

    it { expect(response).to have_http_status :ok }
    it { expect(response).to render_template '_form' }
    it { expect(response).to be_success }
  end
end
