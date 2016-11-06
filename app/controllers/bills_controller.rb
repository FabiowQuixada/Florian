class BillsController < ApplicationController

  include IndexAction
  include CreationActions
  include ModificationActions
  include DestroyAction

  private #########################################################################################

  def bill_params
    params.require(:bill).permit(:id, :competence, :water, :energy, :telephone)
  end

  def index_sorting_method
    list = Bill.order 'competence DESC'
    populate_graph list
    list.page(params[:page])
  end

  def populate_graph(list)
    @graph_data ||= {}

    list.each do |bill|
      Bill.bill_types.each { |type| populate_graph_by_type(bill, type) }
    end
  end

  def populate_graph_by_type(bill, type)
    year = bill.competence.year
    month = bill.competence.month
    month_abbr = I18n.t(:abbr_month_names, scope: :date)[month]
    bill_type_value = bill.send(type[0]).to_f

    @graph_data[year] ||= {}
    @graph_data[year][type[1]] ||= []
    @graph_data[year][type[1]][month-1] = [month_abbr, bill_type_value]
  end
end
