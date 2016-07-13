require 'rails_helper'

describe 'bills/_form', type: :view do
  let(:class_name) { Bill }
  it_behaves_like 'an form view'
end
