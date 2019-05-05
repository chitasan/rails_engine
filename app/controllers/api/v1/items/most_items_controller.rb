class Api::V1::Items::MostItemsController < ApplicationController
  def index
    top_items = Item.items_by_inventory_sold(params[:quantity])
    render json: ItemSerializer.new(top_items)
  end 
end 