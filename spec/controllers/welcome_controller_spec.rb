require 'rails_helper'

describe WelcomeController, type: :controller do
  before(:each) do
    sign_in User.first
  end

  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
