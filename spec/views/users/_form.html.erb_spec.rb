require 'rails_helper'

describe 'users/_form', type: :view do
  let(:class_name) { User }
  it_behaves_like 'an form view'
end
