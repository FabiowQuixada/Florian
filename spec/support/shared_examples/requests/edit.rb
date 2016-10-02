shared_examples 'edit request tests' do
  describe 'GET #edit' do
    render_views

    before :each do
      get :edit, id: model_class.first.id
    end

    it { expect(response).to have_http_status :ok }
    it { expect(response).to render_template '_form' }
    it { expect(response).to be_success }
  end
end
