require 'rails_helper'

describe ProductAndServiceDataController, type: :controller do
  before :each do
    sign_in User.first
  end

  include_examples 'index request tests'
  include_examples 'new request tests'
  include_examples 'create request tests with valid attributes'
  include_examples 'edit request tests'
  include_examples 'update request tests', competence: Date.new(2015, 6, 1)
  include_examples 'destroy tests'

  it 'creates a new product_and_service_datum' do
    expect { post :create, product_and_service_datum: build(:product_and_service_datum).attributes }.to change { ProductAndServiceDatum.count }.by(1)
    expect { post :create, product_and_service_datum: build(:product_and_service_datum).attributes }.to change { ProductAndServiceWeek.count }.by(7)
    expect { post :create, product_and_service_datum: build(:product_and_service_datum).attributes }.to change { ProductData.count }.by(7)
    expect { post :create, product_and_service_datum: build(:product_and_service_datum).attributes }.to change { ServiceData.count }.by(14)
  end

  describe 'POST #create' do
    context 'with invalid attributes' do
      # Special case
      # it { expect { post :create, product_and_service_datum: build(:product_and_service_datum, :invalid).attributes }.not_to change { ProductAndServiceDatum.count } }

      it 're-renders new' do
        post :create, product_and_service_datum: build(:product_and_service_datum, :invalid).attributes

        # Special case
        expect(response).to have_http_status :found
        expect(response).to redirect_to product_and_service_data_path
      end
    end
  end
end
