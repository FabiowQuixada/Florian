require 'rails_helper'

describe 'users/index', type: :view do
  let(:class_name) { User }
  it_behaves_like 'an index view'
end
