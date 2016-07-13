require 'rails_helper'

describe 'donations/index', type: :view do
  let(:class_name) { Donation }
  it_behaves_like 'an index view'
end
