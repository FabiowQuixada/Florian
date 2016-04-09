class BillsController < ApplicationController

  include MainConcern
  arguable model_class: Bill
  load_and_authorize_resource

  private

  def bill_params
    params.require(:bill).permit(:id, :competence, :water, :energy, :telephone)
  end

  def order_attribute
    "competence DESC"
  end

  def index_sorting_method

    list = Bill.order(:competence)

    @listOfLists = Hash.new

    list.each_with_index do |it, index|

      year = it.competence.year
      month = it.competence.month

      if !@listOfLists[year]
        
        @listOfLists[year] = Array.new 

        for i in 0..11 do
          @listOfLists[year][i] = Array.new 
          @listOfLists[year][i][0] = "0,00"
          @listOfLists[year][i][1] = "0,00"
          @listOfLists[year][i][2] = "0,00"
        end
      end

      @listOfLists[year][month-1][0] = it.water.to_s
      @listOfLists[year][month-1][1] = it.energy.to_s
      @listOfLists[year][month-1][2] = it.telephone.to_s

    end

    list

  end 

end
