require 'rails_helper'

describe 'roles/_form', type: :view do
  let(:class_name) { Role }
  it_behaves_like 'an form view'
end
