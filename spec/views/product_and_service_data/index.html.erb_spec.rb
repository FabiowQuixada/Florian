require 'rails_helper'

describe 'product_and_service_data/index', type: :view do
  let(:class_name) { ProductAndServiceDatum }
  it_behaves_like 'an index view'
end
