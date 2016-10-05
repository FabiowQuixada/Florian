require 'rails_helper'

describe WelcomeController, type: :controller do
  context 'logged in' do
    before :each do
      sign_in User.first
      get :index
    end

    it { expect(response).to be_success }
    it { expect(response).to have_http_status :ok }
    it { expect(response).to render_template 'index' }
  end

  context 'not logged in' do
    it { expect(response).to be_success }
    it { expect(response).to have_http_status :ok }
    it { expect(response).not_to render_template 'index' }
  end
end
