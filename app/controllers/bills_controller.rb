class BillsController < ApplicationController

  include IndexAction
  include CreationActions
  include ModificationActions
  include DestroyAction

  private #########################################################################################

  def bill_params
    params[:bill][:competence] = formatted_date params[:bill][:competence]
    params.require(:bill).permit(:id, :competence, :water, :energy, :telephone)
  end

  def index_query
    populate_graph Bill.order competence: :desc
    format_filter_date :competence_gteq
    format_filter_date :competence_lteq
    @q = Bill.ransack(params[:q])
    @q.result.order(competence: :desc).page(params[:page])
  end

  def populate_graph(list)
    @graph_data ||= {}

    list.each do |bill|
      Bill.bill_types.each { |type| populate_graph_by_type(bill, type) }
      populate_totals_graph(bill)
    end
  end

  def populate_graph_by_type(bill, type)
    populate(
      bill.competence.year,
      bill.competence.month,
      I18n.t(:abbr_month_names, scope: :date)[bill.competence.month],
      type,
      bill.send(type[0]).to_f
    )
  end

  def populate_totals_graph(bill)
    populate(
      bill.competence.year,
      bill.competence.month,
      I18n.t(:abbr_month_names, scope: :date)[bill.competence.month],
      [:total, 3],
      (bill.water + bill.energy + bill.telephone).to_f
    )
  end

  def populate(year, month, month_abbr, type, bill_type_value)
    @graph_data[year] ||= {}
    @graph_data[year][type[1]] ||= []
    @graph_data[year][type[1]][month - 1] = [month_abbr, bill_type_value]
  end
end
