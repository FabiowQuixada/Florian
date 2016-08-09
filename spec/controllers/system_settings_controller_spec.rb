require 'rails_helper'

describe SystemSettingsController, type: :controller do
  # include_examples 'destroy tests', SystemSetting

  # == Admin ====================================================================================================
  context 'access as admin user' do
    let(:user) { User.first }
    let(:model) { user.system_setting }
    before(:each) do
      sign_in user
    end

    describe 'GET #index' do
      before(:each) do
        get :index
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('index') }
      it { expect(response).to be_success }
    end

    describe 'GET #edit - own settings' do
      before(:each) do
        get :edit, id: user.system_setting.id
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('_form') }
      it { expect(response).to be_success }
    end

    describe 'GET #edit - other users settings' do
      before(:each) do
        get :edit, id: User.last.system_setting.id
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('_form') }
      it { expect(response).to be_success }
    end

    describe 'PUT #update - own settings' do
      before(:each) do
        put :update, id: model.id, system_setting: attributes_for(:system_setting, re_title: 're-title')
        model.reload
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to system_settings_path }
      it { expect(model.re_title).to eq('re-title') }
    end

    describe 'PUT #update - own (invalid) settings' do
      before(:each) do
        put :update, id: model.id, system_setting: attributes_for(:system_setting, re_title: nil)
        model.reload
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('_form') }
      it { expect(model.re_title).not_to be_nil }
    end

    describe 'PUT #update - other users settings' do
      let(:model2) { User.last.system_setting }
      before(:each) do
        put :update, id: model2.id, system_setting: attributes_for(:system_setting, pse_recipients_array: 'whatever')
        model2.reload
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to system_settings_path }
    end
  end

  # == Common user - own ==========================================================================================

  context 'access to own settings as common user' do
    describe 'GET #index' do
      let(:user) { User.last }
      let(:model) { user.system_setting }

      before(:each) do
        sign_in user
        get :index
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to(edit_system_setting_path(model.id)) }
    end

    describe 'GET #edit' do
      let(:user) { User.last }
      let(:model) { user.system_setting }

      before(:each) do
        sign_in user
        get :edit, id: model.id
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('_form') }
      it { expect(response).to be_success }
    end

    describe 'PUT #update - own settings' do
      let(:user) { User.last }
      let(:model) { user.system_setting }

      before(:each) do
        sign_in user
        put :update, id: model.id, system_setting: attributes_for(:system_setting, re_title: 're-title')
        model.reload
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to(system_settings_path) }
      it { expect(model.re_title).to eq('re-title') }
    end

    describe 'PUT #update - own (invalid) settings' do
      let(:user) { User.last }
      let(:model2) { user.system_setting }

      before(:each) do
        sign_in user
        put :update, id: model2.id, system_setting: attributes_for(:system_setting, re_title: nil)
        model2.reload
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template('_form') }
      it { expect(model2.re_title).not_to be_nil }
    end
  end

  # == Common user- others ========================================================================================

  context 'try to access another users settings' do
    describe 'GET #index' do
      let(:user) { User.last }
      let(:model) { user.system_setting }

      before(:each) do
        sign_in user
        get :index
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to(edit_system_setting_path(model.id)) }
    end

    describe 'GET #edit' do
      let(:user) { User.last }
      let(:model) { user.system_setting }

      before(:each) do
        sign_in user
        get :edit, id: User.first.system_setting.id
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to url_for(controller: :errors, action: :not_found) }
    end

    describe 'PUT #update - other users settings' do
      let(:user) { User.last }
      let(:model2) { User.first.system_setting }

      before(:each) do
        sign_in user
        put :update, id: model2.id, system_setting: attributes_for(:system_setting, pse_recipients_array: 'whatever')
        model2.reload
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to url_for(controller: :errors, action: :not_found) }
      it { expect(model2.pse_recipients_array).not_to eq 'whatever' }
    end
  end
end
