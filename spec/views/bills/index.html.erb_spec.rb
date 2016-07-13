require 'rails_helper'

describe 'bills/index', type: :view do
  before :all do
    assign :graph_data, [] # TODO
  end

  let(:class_name) { Bill }
  it_behaves_like 'an index view'
end
