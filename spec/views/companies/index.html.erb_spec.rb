require 'rails_helper'

describe 'companies/index', type: :view do
  let(:class_name) { Company }
  it_behaves_like 'an index view'
end
