require 'rails_helper'

describe 'roles/index', type: :view do
  let(:class_name) { Role }
  it_behaves_like 'an index view'
end
