class BillsController < ApplicationController

  include MainConcern
  arguable model_class: Bill
  load_and_authorize_resource

  private

  def bill_params
    params.require(:bill).permit(:id, :competence, :water, :energy, :telephone)
  end

  def order_attribute
    'competence DESC'
  end

  def index_sorting_method

    list = Bill.order(:competence)

    @list_of_lists = {}

    list.each do |it|
      year = it.competence.year
      month = it.competence.month

      initialize_year year
      populate_month month, year
    end

    list
  end

  def initialize_year(year)
    @list_of_lists[year] = []

    [0..11].each do |i|
      @list_of_lists[year][i] = []
      @list_of_lists[year][i] += ['0,00', '0,00', '0,00']
    end
  end

  def populate_month(month, year)
    @list_of_lists[year][month - 1] = []
    @list_of_lists[year][month - 1] += [it.water.to_s, it.energy.to_s, it.telephone.to_s]
  end

end
