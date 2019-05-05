class Api::V1::Items::MostRevenueController < ApplicationController
  def index
    most_revenue_items = Item.items_with_most_revenue(params[:quantity])
    render json: ItemSerializer.new(most_revenue_items)
  end 
end 