shared_examples 'index request tests' do
  describe 'GET #index' do
    render_views

    before :each do
      get :index
    end

    it { expect(response).to have_http_status :ok }
    it { expect(response).to render_template 'index' }
    it { expect(response).to be_success }
  end
end
