require 'rails_helper'

describe BillHelper do
  it { expect(helper.graph_btn).to eq link_to t('other.graph.other'), 'javascript:void(0)', id: 'graphs_btn', class: 'btn btn-primary' }
end
