module BillHelper
  def graph_btn
    link_to t('other.graph.other'), 'javascript:void(0)', id: 'graphs_btn', class: 'btn btn-primary'
  end
end
