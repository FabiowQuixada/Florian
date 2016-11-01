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
    list = Bill.order('competence DESC').page(params[:page])
    initialize_year(Date.today.year)

    list.each do |bill|
      year = bill.competence.year
      month = bill.competence.month

      initialize_year year
      populate_month bill, month, year
    end

    list
  end

  def initialize_year(year)
    @graph_data ||= {}
    return unless @graph_data[year].nil?
    @graph_data[year] = []
  end

  def populate_month(bill, month, year)
    @graph_data ||= {}
    @graph_data[year] ||= []
    @graph_data[year][month - 1] = [bill.water.to_s, bill.energy.to_s, bill.telephone.to_s]
  end

end
