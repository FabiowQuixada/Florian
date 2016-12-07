require 'rails_helper'

describe ProductAndServiceWeeksController, type: :controller do
  let(:datum_created) { create :product_and_service_datum, :created }
  let(:datum_on_analysis) { create :product_and_service_datum, :on_analysis }
  let(:datum_finalized) { create :product_and_service_datum, :finalized }

  before :each do
    sign_in User.first
  end

  describe 'POST #update_and_send' do
    it 'sends e-mail if its started' do
      post :update_and_send, product_and_service_week: { id: datum_created.weeks.first.id }
      expect(response).to have_http_status :found
      expect(response).to redirect_to '/product_and_service_data'
    end

    it 'does not send if its on analysis' do
      post :update_and_send, product_and_service_week: { id: datum_on_analysis.weeks.first.id }
      expect(response).to have_http_status :precondition_failed
      expect(response).to render_template 'product_and_service_data/_form'
    end

    it 'does not send if its finalized' do
      post :update_and_send, product_and_service_week: { id: datum_finalized.weeks.first.id }
      expect(response).to have_http_status :precondition_failed
      expect(response).to render_template 'product_and_service_data/_form'
    end
  end

  # == To analysis ==========================================================================================

  describe 'POST #send_to_analysis' do
    it 'sends e-mail if its started' do
      post :send_to_analysis, product_and_service_week: { id: datum_created.weeks.first.id }
      expect(response).to have_http_status :found
      expect(response).to redirect_to '/product_and_service_data'
    end

    it 'does not send if its on analysis' do
      post :send_to_analysis, product_and_service_week: { id: datum_on_analysis.weeks.first.id }
      expect(response).to have_http_status :precondition_failed
      expect(response).to render_template 'product_and_service_data/_form'
    end

    it 'does not send if its finalized' do
      post :send_to_analysis, product_and_service_week: { id: datum_finalized.weeks.first.id }
      expect(response).to have_http_status :precondition_failed
      expect(response).to render_template 'product_and_service_data/_form'
    end
  end

  # == To maintainers ==========================================================================================

  describe 'POST #send_maintainers' do
    it 'does not send e-mail if its started' do
      post :send_maintainers, product_and_service_week: { id: datum_created.weeks.first.id }
      expect(response).to have_http_status :precondition_failed
      expect(response).to render_template 'product_and_service_data/_form'
    end

    it 'sends if its on analysis' do
      post :send_maintainers, product_and_service_week: { id: datum_on_analysis.weeks.first.id }
      expect(response).to have_http_status :found
      expect(response).to redirect_to product_and_service_data_path
    end

    it 'does not send if its finalized' do
      post :send_maintainers, product_and_service_week: { id: datum_finalized.weeks.first.id }
      expect(response).to have_http_status :precondition_failed
      expect(response).to render_template 'product_and_service_data/_form'
    end
  end
end
