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
    list = Bill.order(:competence)
    @graph_data = {}

    list.each do |bill|
      year = bill.competence.year
      month = bill.competence.month

      initialize_year year
      populate_month bill, month, year
    end

    list
  end

  def initialize_year(year)
    return unless @graph_data[year].nil?

    @graph_data[year] = []

    (0..11).each do |month|
      @graph_data[year][month] ||= ['0,00', '0,00', '0,00']
    end
  end

  def populate_month(bill, month, year)
    @graph_data[year][month - 1] = [bill.water.to_s, bill.energy.to_s, bill.telephone.to_s]
  end

end
