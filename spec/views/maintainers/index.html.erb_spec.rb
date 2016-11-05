require 'rails_helper'

describe 'maintainers/index', type: :view do
  let(:class_name) { Maintainer }
  it_behaves_like 'an index view'
end
