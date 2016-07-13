require 'rails_helper'

describe 'donations/_form', type: :view do
  let(:class_name) { Donation }
  it_behaves_like 'an form view'
end
