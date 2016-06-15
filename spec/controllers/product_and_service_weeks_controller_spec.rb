require 'rails_helper'

describe ProductAndServiceWeeksController, type: :controller do
  before(:each) do
    sign_in User.first
    @datum_created = create :product_and_service_datum, :created
    @datum_on_analysis = create :product_and_service_datum, :on_analysis
    @datum_finalized = create :product_and_service_datum, :finalized
  end

  describe 'POST #update_and_send' do
    it 'sends e-mail if its started' do
      post :update_and_send, product_and_service_week: { id: @datum_created.weeks.first.id }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to '/product_and_service_data'
    end

    it 'does not send if its on analysis' do
      post :update_and_send, product_and_service_week: { id: @datum_on_analysis.weeks.first.id }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template('product_and_service_data/_form')
    end

    it 'does not send if its finalized' do
      post :update_and_send, product_and_service_week: { id: @datum_finalized.weeks.first.id }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template('product_and_service_data/_form')
    end
  end

  # == To analysis ==========================================================================================

  describe 'POST #send_to_analysis' do
    it 'sends e-mail if its started' do
      post :send_to_analysis, product_and_service_week: { id: @datum_created.weeks.first.id }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to '/product_and_service_data'
    end

    it 'does not send if its on analysis' do
      post :send_to_analysis, product_and_service_week: { id: @datum_on_analysis.weeks.first.id }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template('product_and_service_data/_form')
    end

    it 'does not send if its finalized' do
      post :send_to_analysis, product_and_service_week: { id: @datum_finalized.weeks.first.id }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template('product_and_service_data/_form')
    end
  end

  # == To clients ==========================================================================================

  describe 'POST #send_clients' do
    it 'does not send e-mail if its started' do
      post :send_clients, product_and_service_week: { id: @datum_created.weeks.first.id }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template('product_and_service_data/_form')
    end

    it 'sends if its on analysis' do
      post :send_clients, product_and_service_week: { id: @datum_on_analysis.weeks.first.id }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to product_and_service_data_path
    end

    it 'does not send if its finalized' do
      post :send_clients, product_and_service_week: { id: @datum_finalized.weeks.first.id }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template('product_and_service_data/_form')
    end
  end
end
